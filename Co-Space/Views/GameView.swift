//
//  GameView.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 05/07/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: MainGame
    
    var body: some View {
        NavigationView {
            VStack {
                if (game.myRole == "security") {
                    SecurityView(game: game)
                }
                else if (game.myRole == "guide") {
                    GuiderView(game: game)
                }
                else if (game.myRole == "cleaner") {
                    CleanerView(game: game)
                }
                else if (game.myRole == "inventory") {
                    InventoryView(game: game)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: MainGame())
    }
}
