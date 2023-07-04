//
//  MainGame+InventoryRole.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame {
    // Panggil kalo inventory beli identity card
    func buyIdentityCard(symbol: String) -> String {
        let coinPrice = 5
        let addAmount = 10
        
        if (self.coin >= coinPrice){
            self.availableIdCard[symbol]? += addAmount
            updateCoin(add: false, amount: coinPrice)
            
            do {
                // perbarui jumlah id card
                let data = encode(idCard: self.availableIdCard)
                try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
            return "success"
        }
        return "fail"
    }
    
    // Panggil kalo inventory beli potion
    func buyPotion() -> String {
        if (self.health < 5){
            if (self.coin >= self.potionPrice){
                updateCoin(add: false, amount: self.potionPrice)
                updateHealth(add: true, amount: 1)
                
                self.potionPrice += 5
                do {
                    // perbarui potion price
                    let data = encode(potionPrice: self.potionPrice)
                    try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
                } catch {
                    print("Error: \(error.localizedDescription).")
                }
            }
            return "success"
        }
        return "fail"
    }
}
