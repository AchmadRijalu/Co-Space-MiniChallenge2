//
//  GameView.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 05/07/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: MainGame
    @State var isPresented:Bool = false
    @State var timer: Timer? = nil
    @State var isGameOver:Bool = false
    @State var isStart: Int = 0
    @State var isPlayingAgain = false
    @State var isExit = false
    
    var body: some View {
        NavigationView {
            ZStack{
                NavigationLink(
                    destination: RoleRevealView(game: game),
                    isActive: $isPlayingAgain,
                    label: EmptyView.init
                )
                NavigationLink(
                    destination: MainmenuView(),
                    isActive: $isExit,
                    label: EmptyView.init
                )
                VStack {
                    ZStack{
                        if isStart == 1 {
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
                        
                        if isGameOver {
                            ResultView(game: game)
                        }
                    }
                }
            }
            .onAppear {
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
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    if (self.game.health <= 0) {
                        isStart = 3
                        isGameOver = true
                    }
                    
                    if (self.game.playAgain) {
                        timer.invalidate()
                        isGameOver = false
                        isPlayingAgain = true
                    }
                    
                    if (self.game.exit) {
                        timer.invalidate()
                        isExit = true
                        isGameOver = false
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(game: MainGame()).previewInterfaceOrientation(.landscapeLeft)
//    }
//}
