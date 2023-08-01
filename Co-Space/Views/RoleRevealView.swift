//
//  RoleRevealView.swift
//  Co-Space
//
//  Created by Billy Agustian Dharmawan on 01/07/23.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct RoleRevealView: View {
    @ObservedObject var game: MainGame
    @State var startTimer: Timer?
    @State var timerCount = 15
    @State var isMovingToGameView = false
    @State var iShowScene:Bool = false
    
    var scene = SKScene(fileNamed: "RoleRevealScene.sks") as! RoleRevealScene
    
    
    var sceneLoading = SKScene(fileNamed: "RoleRevealLoadingScene.sks") as! RoleRevealSceneLoading
    
   
    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                NavigationLink(
                    destination: GameView(game: game),
                    isActive: $isMovingToGameView,
                    label: EmptyView.init
                )
                if self.iShowScene {
                    SpriteView(scene: scene)
                        .task{
                            scene.game = game
                        }
                        .ignoresSafeArea()
                }
                else {
                    //Loading shuffling role
                    
                }
               
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
                        .padding(.horizontal, 30)
                        .padding(.bottom, 10)
                        .background(Color(#colorLiteral(red: 0.5612951517, green: 0.5604736209, blue: 0.7392155528, alpha: 1))).cornerRadius(12)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.purple)
            .ignoresSafeArea()
        }
        .task{
            
            startTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                timerCount -= 1
                if (timerCount <= 0){
                    startTimer?.invalidate()
                    isMovingToGameView = true
                }
                if timerCount == 13{
                    self.iShowScene = true
                }
            }
        }
        .onAppear {
            if (self.game.playAgain == true) {
                self.game.playAgain = false
            }
            if (self.game.exit == true) {
                self.game.exit = false
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
