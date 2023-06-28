//
//  MainGame+GlobalFunction.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 28/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame{
    // Panggil buat perbarui coin ke semua orang (pake param add true klo nambah, false kalo ngurang)
    func updateCoin(add: Bool, amount: Int) {
        if add{
            self.coin += amount
        } else {
            self.coin -= amount
        }
        
        do {
            // perbarui coin
            let data = encode(coin: self.coin)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    // Panggil buat perbarui health ke semua orang (pake param add true klo nambah, false kalo ngurang)
    func updateHealth(add: Bool, amount: Int) {
        if add{
            self.health += amount
        } else {
            self.health -= amount
        }
        checkHealth()
        
        do {
            // perbarui health
            let data = encode(health: self.health)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func checkHealth() {
        if self.health <= 0 {
            print("You lose")
            // Code buat end game
        }
    }
    
    // Panggil buat nambah score
    func addScore(amount: Int) {
        self.score += amount
        
        do {
            // perbarui score
            let data = encode(score: self.score)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
