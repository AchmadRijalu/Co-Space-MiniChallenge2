//
//  MainGame+CleanerRole.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame {
    func randomizeDrawer() {
        var cleaningItemShuffled = cleaningItemAndPoop.shuffled()
        for k in self.drawerContent.keys {
            if let chosenItem = cleaningItemShuffled.popLast() {
                self.drawerContent[k] = chosenItem
            }
        }
        
        do {
            // perbarui isi drawer
            let data = encode(drawerContent: self.drawerContent)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func updatePoopState(newState: Int) {
        self.poopState = newState
        
        do {
            // perbarui poop state
            let data = encode(poopState: self.poopState)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func sendCleanedSeatToGuide(symbol: String, number: Int) {
        do {
            let data = encode(newCleaned: [symbol, String(number)])
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
