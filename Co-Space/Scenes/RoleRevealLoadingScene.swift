//
//  RoleRevealLoadingScene.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 29/07/23.
//

import Foundation
import SpriteKit


class RoleRevealSceneLoading : SKScene{
    
    
    var loadingTextCenter : String = "Now Loading"
    var loadingTextCenterSecond : String = "Revealing Character"
    var backgroundNode = SKSpriteNode()
    override func didMove(to view: SKView) {
        
    }
    
    func createBackgroundNode(){
        scene?.backgroundColor = .black
        backgroundNode.size = self.size
        backgroundNode.color = SKColor.black.withAlphaComponent(0.9)
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
    }
    
    func addTextLabel() {
        let labelNode = SKLabelNode(text: self.loadingTextCenter)
        labelNode.fontSize = 24
        labelNode.fontColor = .white
        labelNode.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        labelNode.zPosition = 0
        
        addChild(labelNode)
        
        let labelNode2 = SKLabelNode(text: loadingTextCenterSecond)
        labelNode2.fontSize = 24
        labelNode2.fontColor = .white
        labelNode2.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        labelNode2.zPosition = 0 // Put it above the black background
        
        addChild(labelNode2)
    }
}

