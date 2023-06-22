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
    
    //this section is defining the entire gamescreen
    var scene:SKScene{
        let scene = GuiderGameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = SKColor(named: "BackgroundColor") ?? .blue
        return scene
    }
    var body: some View {
        VStack{
            SpriteView(scene: scene)
        }.ignoresSafeArea()
    }
}

struct GuiderView_Previews: PreviewProvider {
    static var previews: some View {
        GuiderView().previewInterfaceOrientation(.landscapeRight)
    }
}

