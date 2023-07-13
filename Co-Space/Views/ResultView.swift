//
//  ResultView.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 04/07/23.
//

import SwiftUI
import SpriteKit

struct ResultView: View {
    @ObservedObject var game: MainGame
    
    var scene = SKScene(fileNamed: "ResultGameScene.sks") as! ResultGameScene
    let backgroundOpacity: Double = 0.1
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene, options: [.allowsTransparency], debugOptions: []).ignoresSafeArea()
            }
            .task{
                scene.game = game
                scene.backgroundColor = .clear
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden()
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(game: MainGame()).previewInterfaceOrientation(.landscapeLeft)
    }
}
