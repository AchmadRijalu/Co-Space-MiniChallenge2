//
//  RoleRevealView.swift
//  Co-Space
//
//  Created by Billy Agustian Dharmawan on 01/07/23.
//

import SwiftUI
import SpriteKit

struct RoleRevealView: View {
    
    var scene = SKScene(fileNamed: "RoleRevealScene.sks")
    var body: some View {
        SpriteView(scene: scene!)
            .ignoresSafeArea()
    }
}

struct RoleRevealView_Previews: PreviewProvider {
    static var previews: some View {
        RoleRevealView().previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
