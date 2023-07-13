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
    @State var goToResult = false
    
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: ResultView(game: game),
                isActive: $goToResult,
                label: EmptyView.init
            )
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
                    
                    if isPresented == true{
                        ResultView(game: game)
                    }
                }
               
            }
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    if (self.game.health < 3) {
                        goToResult = true
                        timer.invalidate()
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
