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
    @State var isStart: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    if isStart == 1 {
                            let a = print("gamestart")
                            GameStartView()
                        } else if isStart == 2 {
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
                    
                    
                    if isGameOver == true{
                        ResultView(game: game)
                    }
                }
               
            }
            .onAppear {
                print("appear")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        isStart = 1
                    }

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.7) {
                    withAnimation {
                        isStart = 2
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: MainGame()).previewInterfaceOrientation(.landscapeLeft)
    }
}
