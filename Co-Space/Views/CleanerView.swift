//
//  CleanerView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct CleanerView: View {
    @ObservedObject var game : MainGame
//    var scene: SKScene {
//          let scene = CleanerGameScene()
//          scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//          scene.scaleMode = .aspectFill
//          return scene
//      }
    
    var scene = SKScene(fileNamed: "CleanerGameScene.sks") as! CleanerGameScene
    
      
      var body: some View {
          SpriteView(scene: scene)
              .onAppear{
                  scene.game = game
              }
              .ignoresSafeArea()
      }
}

struct CleanerView_Previews: PreviewProvider {
    static var previews: some View {
        CleanerView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
