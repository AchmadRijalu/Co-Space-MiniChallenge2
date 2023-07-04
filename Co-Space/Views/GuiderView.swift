//
//  GuiderView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct GuiderView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var scene = SKScene(fileNamed: "GuiderGameScene.sks") as! GuiderGameScene
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene).ignoresSafeArea()
            }.ignoresSafeArea().onAppear(){
                scene.size = CGSize(width: screenWidth, height: screenHeight)
                scene.scaleMode = .fill
                scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct GuiderView_Previews: PreviewProvider {
    static var previews: some View {
        GuiderView().previewInterfaceOrientation(.landscapeRight)
    }
}

