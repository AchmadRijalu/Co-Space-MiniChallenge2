//
//  RoleRevealView.swift
//  Co-Space
//
//  Created by Billy Agustian Dharmawan on 01/07/23.
//

import SwiftUI
import SpriteKit

struct RoleRevealView: View {
    @ObservedObject var game: MainGame
    @State var startTimer: Timer?
    @State var timerCount = 5
    @State var isMovingToGameView = false
    
    var scene = SKScene(fileNamed: "RoleRevealScene.sks") as! RoleRevealScene
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                NavigationLink(
                    destination: GameView(game: game),
                    isActive: $isMovingToGameView,
                    label: EmptyView.init
                )
                
                SpriteView(scene: scene)
                    .onAppear{
                        scene.game = self.game
                        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        scene.scaleMode = .fill
                        scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
                    }
                    .ignoresSafeArea()
                
                VStack(alignment: .trailing){
                    HStack{
                        Spacer()
                        VStack{
                            Text("Game Starts In")
                                .font(.system(size:12))
                                .foregroundColor(.white)
                                .padding(.top, 70)
                            Text("\(timerCount)")
                                .font(.system(size:30, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 30)
                        .padding(.bottom, 10)
                        .background(Color(#colorLiteral(red: 0.5612951517, green: 0.5604736209, blue: 0.7392155528, alpha: 1)))
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.purple)
            .ignoresSafeArea()
        }
        .onAppear{
            startTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                timerCount -= 1
                if (timerCount <= 0){
                    startTimer?.invalidate()
                    isMovingToGameView = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RoleRevealView_Previews: PreviewProvider {
    static var previews: some View {
        RoleRevealView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
