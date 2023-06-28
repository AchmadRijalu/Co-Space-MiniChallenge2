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
    // Panggil waktu pencet tempat yang ada poopnya
    // Bakal ngerandom poop trs update ke semuanya dan sekaligus randomize drawer buat inventory dan cleaner
    func randomizePoop(){
        randomizeDrawer()
        
        var poopShuffled = cleaningItemAndPoop.shuffled()
        if let chosenPoop = poopShuffled.popLast() {
            updatePoop(poop: chosenPoop)
        }
    }
    
    private func updatePoop(poop: String){
        self.activePoop = poop
        do {
            // perbarui isi drawer
            let data = encode(poop: self.activePoop)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    private func randomizeDrawer() {
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
    
    // Panggil waktu cleaner coba nebak drawer
    func guessDrawer(symbol: String) -> String {
        if (drawerContent[symbol] == self.activePoop) {
            updatePoop(poop: "")
            return "success" //Kalo success nnti hilangin poopnya
        }
        else {
            updateHealth(add: false, amount: 1)
            return "fail"
        }
    }
}
