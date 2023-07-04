//
//  SecurityView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct SecurityView: View {
    var scene: SKScene {
        let scene = SecurityGameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView().previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
