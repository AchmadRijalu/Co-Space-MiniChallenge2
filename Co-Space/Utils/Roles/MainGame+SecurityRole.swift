//
//  MainGame+SecurityRole.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame {
    // Panggil pas pake identity card ke guest
    func useIdentityCard(symbol: String) -> String{
        if (self.availableIdCard[symbol]! > 0){
            self.availableIdCard[symbol]! -= 1
            
            do {
                // perbarui jumlah id card
                let data = encode(idCard: self.availableIdCard)
                try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
            
            return "success"
        }
        return "fail" // Kalo fail brarti ga cukup
    }
    
    // Send Guest to Guide
}
