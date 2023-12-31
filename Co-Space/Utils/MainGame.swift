//
//  MainGame.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

/// - Tag:RealTimeGame
@MainActor
class MainGame: NSObject, GKGameCenterControllerDelegate, ObservableObject {
    // =========================== MAIN GAME PROPERTIES ===========================
    @Published var playerNumberMin = 4
    @Published var playerNumberMax = 4
    
    /// The game interface state.
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    var playAgain = false
    var exit = false

    /// Self Profile
    @Published var isHost = false
    @Published var myRole: String = ""
    
    /// Game communication
    @Published var messages: [Message] = []
    
    /// Game Properties
    var patienceRangeSecurity = ["start": 8, "end": 10] // will change to 5-7
    var patienceRangeGuide = ["start": 3, "end": 5] // will change to 2-4
    var watchingTimeRange = ["start": 5, "end": 8] // will change to 7-10
    var score = 0
    var coin = 0
    var health = 5
    var potionPrice = 10 
                           
    /// The voice chat properties.
    @Published var voiceChat: GKVoiceChat? = nil
    @Published var opponentSpeaking = false
    
    // =========================== ROLE SECURITY PROPERTIES ===========================
    var idCardSquare: Int = 10
    var idCardCircle: Int = 10
    var idCardTriangle: Int = 10
    var newGuestData: [[String]] = []
    
    // =========================== ROLE GUIDE PROPERTIES ===========================
    var newCleanedSeat: [[String]] = []
    
    // =========================== ROLE CLEANER PROPERTIES ===========================
    // 0 = No poop active || 1 = poop active || 2 = poop cleaning done
    var poopState = 0
    var newDirtySeatCleaner: [[String]] = []
    
    // =========================== ROLE INVENTORY PROPERTIES ===========================
    let cleaningItemAndPoop = ["green", "orange", "brown"]
    var drawerContent: [String: String] = ["sun": "green", "moon": "brown", "star": "orange"]
    
    /// The root view controller of the window.
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }

    /// Authenticates the local player, initiates a multiplayer game, and adds the access point.
    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }
            
            // A value of nil for viewController indicates successful authentication, and you can access
            // local player properties.

            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
            
            // Add an access point to the interface.
            // Access Point itu kyk tampilan mini profile game center yang bisa akses achievement apa aja dll di kiri atas (appnya)
            GKAccessPoint.shared.location = .topLeading
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = true
            
            // Enable the Start Game button.
            self.matchAvailable = true
        }
    }
    
    // Starts the matchmaking process where GameKit finds a player for the match.
    func findPlayer() async {
        let request = GKMatchRequest()
        request.minPlayers = self.playerNumberMin
        request.maxPlayers = self.playerNumberMax
        let match: GKMatch
        
        // Start automatch.
        do {
            match = try await GKMatchmaker.shared().findMatch(for: request)
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }
        
        // Start the game, although the automatch player hasn't connected yet.
        if !playingGame {
            startGame(match: match)
        }

        // Stop automatch.
        GKMatchmaker.shared().finishMatchmaking(for: match)
        automatch = false
    }
    
    // Presents the matchmaker interface where the local player selects and sends an invitation to another player.
    func createRoom() {
        // Create a match request.
        let request = GKMatchRequest()
        request.minPlayers = self.playerNumberMin
        request.maxPlayers = self.playerNumberMax
        
        // Present the interface where the player selects opponents and starts the game.
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
//            viewController.matchmakingMode = GKMatchmakingMode.inviteOnly
            viewController.matchmakerDelegate = self
            viewController.canStartWithMinimumPlayers = true
            rootViewController?.present(viewController, animated: true) { }
        }
        
    }
    
    // Starting and stopping the game.
    func startGame(match: GKMatch) {
       
        GKAccessPoint.shared.isActive = false
        self.playingGame = true
        myMatch = match
        myMatch?.delegate = self
            
        defineHost()
        shuffleRole()
        
        // Increment the achievement to play 10 games.
        reportProgress()
    }
    
    private func defineHost(){
        var nameArray: [String] = []
        
        nameArray.append(GKLocalPlayer.local.displayName)
        
        // Masukin semua player selain localplayer
        let gamePlayers: [GKPlayer] = myMatch?.players ?? []
        for p in gamePlayers{
            nameArray.append(p.displayName)
        }
        nameArray.sort(by: <)
        
        if (nameArray[0] == GKLocalPlayer.local.displayName){
            isHost = true
        } else {
            isHost = false
        }
    }
    
    // Shuffling Role
    func shuffleRole(){
        if self.isHost {
            let role = ["security", "guide", "cleaner", "inventory"]
//            let role = ["security", "guide"]
            var shuffledRole = role.shuffled()
            
            var assignedRoles: [String: String] = [:]
            
            // Assign role ke player local dulu
            if let chosenRole = shuffledRole.popLast() {
                self.myRole = chosenRole
            }
            // Assign role ke player selain local
            var gamePlayers: [GKPlayer] = myMatch?.players ?? []
            for p in gamePlayers{
                if let chosenRole = shuffledRole.popLast() {
                    assignedRoles[p.displayName] = chosenRole
                }
            }
            
            // Kirim role" ke player selain local (yg role local gausa dikirim)
            do {
                let data = encode(roles: assignedRoles)
                try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
    
    // Saves the local player's score.
    func saveScore() {
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local,
            leaderboardIDs: ["123456"]) { error in
            if let error {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
    
    // Reset game variable
    func resetMatch() {
        patienceRangeSecurity = ["start": 8, "end": 10] // will change to 5-7
        patienceRangeGuide = ["start": 3, "end": 5] // will change to 2-4
        watchingTimeRange = ["start": 5, "end": 8] // will change to 7-10
        score = 0
        coin = 0
        health = 5
        potionPrice = 10
        
        // =========================== ROLE SECURITY PROPERTIES ===========================
        idCardSquare = 10
        idCardCircle = 10
        idCardTriangle = 10
        newGuestData = []
        
        // =========================== ROLE GUIDE PROPERTIES ===========================
        newCleanedSeat = []
        
        // =========================== ROLE CLEANER PROPERTIES ===========================
        // 0 = No poop active || 1 = poop active || 2 = poop cleaning done
        poopState = 0
        newDirtySeatCleaner = []
        
        // =========================== ROLE INVENTORY PROPERTIES ===========================
        drawerContent = ["sun": "green", "moon": "brown", "star": "orange"]
    }
    
    // Disconnect from match if exited
    func disconnectMatch() {
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        GKAccessPoint.shared.isActive = true
    }
    
    /// Reports the local player's progress toward an achievement.
    func reportProgress() {
        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in
            let achievementID = "1234"
            var achievement: GKAchievement? = nil

            // Find an existing achievement.
            achievement = achievements?.first(where: { $0.identifier == achievementID })

            // Otherwise, create a new achievement.
            if achievement == nil {
                achievement = GKAchievement(identifier: achievementID)
            }

            // Create an array containing the achievement.
            let achievementsToReport: [GKAchievement] = [achievement!]

            // Set the progress for the achievement.
            achievement?.percentComplete = achievement!.percentComplete + 10.0

            // Report the progress to Game Center.
            GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            })

            if let error {
                print("Error: \(error.localizedDescription).")
            }
        })
    }
}
