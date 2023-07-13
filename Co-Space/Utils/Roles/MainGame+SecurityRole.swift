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
        if (symbol == "square"){
            if (self.idCardSquare > 0){
                self.idCardSquare -= 1
            }
            else {
                return "fail"
            }
        }
        else if (symbol == "circle") {
            if (self.idCardCircle > 0){
                self.idCardCircle -= 1
            }
            else {
                return "fail"
            }
        }
        else if (symbol == "triangle") {
            if (self.idCardTriangle > 0){
                self.idCardTriangle -= 1
            }
            else {
                return "fail"
            }
        }
        
        do {
            // perbarui jumlah id card
            let data = encode(idCard: [self.idCardSquare, self.idCardCircle, self.idCardTriangle])
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
        
        return "success"
    }
    
    // Send Guest to Guide
    func sendGuestToGuide(symbol: String, imageName: String) {
        do {
            // perbarui jumlah id card
            let data = encode(newGuest: [symbol, imageName])
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
