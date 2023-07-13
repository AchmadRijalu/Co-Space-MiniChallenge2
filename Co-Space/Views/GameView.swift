//
//  GameView.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 05/07/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: MainGame
    @State var isGameOver:Bool = false
    @EnvironmentObject var isGameStart : GameStartViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
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
                    if isGameStart.isGameStart == false{
                        GameStartView()
                    }
                    
                    if isGameOver == true{
                        ResultView(game: game)
                    }
                }
               
            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    isPresented = true
//                    print(isPresented)
//                }
//            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: MainGame()).previewInterfaceOrientation(.landscapeLeft)
    }
}
