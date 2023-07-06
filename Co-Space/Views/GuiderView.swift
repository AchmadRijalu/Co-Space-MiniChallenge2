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
    var scene = SKScene(fileNamed: "GuiderGameScene.sks") as! GuiderGameScene
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene).ignoresSafeArea()
            }
            .onAppear{
                scene.game = self.game
                scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                scene.scaleMode = .fill
                scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct GuiderView_Previews: PreviewProvider {
    static var previews: some View {
        GuiderView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
    }
}

