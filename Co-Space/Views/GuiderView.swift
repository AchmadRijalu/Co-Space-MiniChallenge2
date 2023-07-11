//
//  GuiderView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct GuiderView: View {
    @ObservedObject var game: MainGame
    @State var timer: Timer?
    
    var scene = SKScene(fileNamed: "GuiderGameScene.sks") as! GuiderGameScene
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene).ignoresSafeArea()
            }
            .task{
                scene.game = self.game
                scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                scene.scaleMode = .fill
                scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
//                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//                    if (scene.game?.health == nil){
//                        scene.game = self.game
//                    }
//                }
            }
            .onTapGesture {
//                scene.game = self.game
//                print("Halo")
                print("Health dari View \(game.health)")
            }
            .ignoresSafeArea()
        }
        .environmentObject(game)
        .navigationBarBackButtonHidden()
    }
}

struct GuiderView_Previews: PreviewProvider {
    static var previews: some View {
        GuiderView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
    }
}

