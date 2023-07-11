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
}
