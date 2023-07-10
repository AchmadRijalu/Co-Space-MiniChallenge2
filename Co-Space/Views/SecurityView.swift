//
//  SecurityView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct SecurityView: View {
    @State var timer: Timer?
    @ObservedObject var game:MainGame
    
    var scene = SKScene(fileNamed: "SecurityGameScene.sks") as! SecurityGameScene
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
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
