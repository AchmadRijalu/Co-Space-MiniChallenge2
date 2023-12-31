//
//  MainGame+EncodeData.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

struct GameData: Codable {
    // Game Properties
    var message: String?
    var coin: Int?
    var health: Int?
    var score: Int?
    var potionPrice: Int?
    var roles: [String:String]?
    var playAgain: Bool?
    var exit: Bool?
    
    // Security Properties
    var identityCard: [Int]?
    var newGuest: [String]?
    
    // Guide Properties
    var newDirtySeat: [String]?
    
    // Cleaner Properties
    var poopState: Int?
    var drawerContent: [String:String]?
    var newCleanedSeat: [String]?
}

extension MainGame {
    // ========================== BUAT UPDATE MESSAGE KE PLAYER LAIN ==========================
    func encode(message: String?) -> Data? {
        let gameData = GameData(message: message)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE COIN KE PLAYER LAIN ==========================
    func encode(coin: Int?) -> Data? {
        let gameData = GameData(coin: coin)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE HEALTH KE PLAYER LAIN ==========================
    func encode(health: Int?) -> Data? {
        let gameData = GameData(health: health)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE SCORE KE PLAYER LAIN ==========================
    func encode(score: Int?) -> Data? {
        let gameData = GameData(score: score)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE POTION PRICE KE PLAYER LAIN ==========================
    func encode(potionPrice: Int?) -> Data? {
        let gameData = GameData(potionPrice: potionPrice)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE ROLES KE PLAYER LAIN ==========================
    func encode(roles: [String:String]?) -> Data? {
        let gameData = GameData(roles: roles)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE PLAY AGAIN KE PLAYER LAIN ==========================
    func encode(playAgainStatus: Bool?) -> Data? {
        let gameData = GameData(playAgain: playAgainStatus)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE EXIT KE PLAYER LAIN ==========================
    func encode(exitStatus: Bool?) -> Data? {
        let gameData = GameData(exit: exitStatus)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE IDENTITY CARD KE PLAYER LAIN ==========================
    func encode(idCard: [Int]?) -> Data? {
        let gameData = GameData(identityCard: idCard)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE NEW GUEST KE PLAYER LAIN ==========================
    func encode(newGuest: [String]?) -> Data? {
        let gameData = GameData(newGuest: newGuest)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE NEW DIRTY SEAT KE PLAYER LAIN ==========================
    func encode(newDirt: [String]?) -> Data? {
        let gameData = GameData(newDirtySeat: newDirt)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE POOP STATE KE PLAYER LAIN ==========================
    func encode(poopState: Int?) -> Data? {
        let gameData = GameData(poopState: poopState)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE NEW CLEANED SEAT KE PLAYER LAIN ==========================
    func encode(newCleaned: [String]?) -> Data? {
        let gameData = GameData(newCleanedSeat: newCleaned)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE DRAWER CONTENT KE PLAYER LAIN ==========================
    func encode(drawerContent: [String:String]?) -> Data? {
        let gameData = GameData(drawerContent: drawerContent)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT ENCODE DAN DECODE OVERALL GAME DATA ==========================
    func encode(gameData: GameData) -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(gameData)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
    
    func decode(matchData: Data) -> GameData? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
}
