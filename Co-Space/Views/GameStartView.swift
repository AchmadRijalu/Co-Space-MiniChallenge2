//
//  GameStartView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 13/07/23.
//

import SwiftUI
import SpriteKit

struct GameStartView: View {
    var scene = SKScene(fileNamed: "GameStartGameScene.sks") as! GameStartGameScene
    
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene, debugOptions: []).ignoresSafeArea()
            }
        } .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
    }
}

struct GameStartView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView().previewInterfaceOrientation(.landscapeLeft)
    }
}
