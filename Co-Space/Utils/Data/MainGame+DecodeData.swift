//
//  MainGame+DecodeData.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame: GKMatchDelegate {
    /// Handles a connected, disconnected, or unknown player state.
    /// - Tag:didChange
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        switch state {
        case .connected:
            print("\(player.displayName) Connected")
        case .disconnected:
            print("\(player.displayName) Disconnected")
        default:
            print("\(player.displayName) Connection Unknown")
        }
    }
    
    /// Handles an error during the matchmaking process.
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        print("\n\nMatch object fails with error: \(error!.localizedDescription)")
    }

    /// Reinvites a player when they disconnect from the match.
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
    
    /// Handles receiving a message from another player.
    /// - Tag:didReceiveData
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        // Decode the data representation of the game data.
        let gameData = decode(matchData: data)
        
        // Update the interface from the game data.
        if let text = gameData?.message {
            // Add the message to the chat view.
            let message = Message(content: text, playerName: player.displayName, isLocalPlayer: false)
            messages.append(message)
        }
        else if let coin = gameData?.coin{
            self.coin = coin
        }
        else if let health = gameData?.health{
            self.health = health
            checkHealth()
        }
        else if let score = gameData?.score{
            self.score = score
        }
        else if let potionPrice = gameData?.potionPrice{
            self.potionPrice = potionPrice
        }
        else if let gameRole = gameData?.roles {
            self.myRole = gameRole[GKLocalPlayer.local.displayName] ?? ""
        }
        else if let idCard = gameData?.identityCard {
            self.availableIdCard = idCard
        }
        else if let newGuest = gameData?.newGuest{
            // Idx 0: Symbol, Idx 1: Image name
            if (self.myRole == "guide") {
                self.newGuestData = newGuest
            }
        }
        else if let poop = gameData?.poop{
            self.activePoop = poop
        }
        else if let drawerContent = gameData?.drawerContent {
            self.drawerContent = drawerContent
        }
    }
}
