//
//  MainGame+EncodeData.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

// MARK: Game Data Objects

struct GameData: Codable {
    // Game Properties
    var message: String?
    var coin: Int?
    var health: Int?
    var score: Int?
    var potionPrice: Int?
    var roles: [String:String]?
    
    // Security Properties
    var identityCard: [String:Int]?
    
    // Cleaner Properties
    var poop: String?
    var drawerContent: [String:String]?
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
    
    // ========================== BUAT UPDATE IDENTITY CARD KE PLAYER LAIN ==========================
    func encode(idCard: [String:Int]?) -> Data? {
        let gameData = GameData(identityCard: idCard)
        return encode(gameData: gameData)
    }
    
    // ========================== BUAT UPDATE POOP KE PLAYER LAIN ==========================
    func encode(poop: String?) -> Data? {
        let gameData = GameData(poop: poop)
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
