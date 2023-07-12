//
//  MainGame+GuideRole.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit
import SwiftUI

extension MainGame {
    func sendDirtySeatToCleaner(symbol: String, number: Int) {
        do {
            let data = encode(newDirt: [symbol, String(number)])
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
