//
//  ResultView.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 04/07/23.
//

import SwiftUI
import SpriteKit

struct ResultView: View {
    var scene = SKScene(fileNamed: "ResultGameScene.sks") as! ResultGameScene
    let backgroundOpacity: Double = 0.1
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene, options: [.allowsTransparency]).ignoresSafeArea()
            }
            .onAppear{
                scene.backgroundColor = .clear
            }
            .edgesIgnoringSafeArea(.all)        }
        .navigationBarBackButtonHidden()
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView().previewInterfaceOrientation(.landscapeLeft)
    }
}
