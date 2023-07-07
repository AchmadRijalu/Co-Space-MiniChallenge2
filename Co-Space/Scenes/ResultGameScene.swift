//
//  ResultGameScene.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 04/07/23.
//

import Foundation
import SpriteKit
import FLAnimatedImage

class ResultGameScene : SKScene,  SKPhysicsContactDelegate{
    
    
    var moonResultNode =  SKSpriteNode()
    var logoResultNode = SKSpriteNode()
    var backgroundNode = SKSpriteNode()
    
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        
        scene?.backgroundColor = .clear
        
        //Background sprite
        backgroundNode.size = self.size
        backgroundNode.color = SKColor.black.withAlphaComponent(0.5)
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(backgroundNode)
        let fadeInActionBackground = SKAction.fadeIn(withDuration: 8.0)
        backgroundNode.run(fadeInActionBackground)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            //Moon sprite
            self.moonResultNode.name = "moonResultNode"
            self.moonResultNode.position = CGPoint(x: 423.855, y: self.size.height + self.moonResultNode.size.height / 2)
            self.moonResultNode.texture = SKTexture(imageNamed: "result-moon")
            self.moonResultNode.size = CGSize(width: 326.067, height: 325.313)
            self.addChild(self.moonResultNode)
            
            let fallAction = SKAction.move(to: CGPoint(x: 423.855, y: 233.825), duration: 0.3)
            let fadeInAction = SKAction.fadeIn(withDuration: 3.0)
            let sequence = SKAction.sequence([fallAction, fadeInAction])
            self.moonResultNode.run(sequence)
            
            //Logo sprite
            self.logoResultNode.name = "logoResultNode"
            self.logoResultNode.texture = SKTexture(imageNamed: "result-logo-game-over")
            self.logoResultNode.size = CGSize(width: 254.459, height: 172.181)
            self.moonResultNode.addChild(self.logoResultNode)
            self.logoResultNode.position = CGPoint(x: 0, y: 0)
            
            let logoInitialScale: CGFloat = 0.0
            let logoFinalScale: CGFloat = 1.0
            let logoAnimationDuration: TimeInterval = 0.5
            let logoAnimationDelay: TimeInterval = 0.5
            
            let scaleDownAction = SKAction.scale(to: logoInitialScale, duration: 0.0)
            let waitAction = SKAction.wait(forDuration: logoAnimationDelay)
            let scaleUpAction = SKAction.scale(to: logoFinalScale, duration: logoAnimationDuration)
            
            // Apply the timing mode to the scaleUpAction
            scaleUpAction.timingMode = .easeOut
            
            let logoSequence = SKAction.sequence([scaleDownAction, waitAction, scaleUpAction])
            self.logoResultNode.run(logoSequence)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) {
            //resize it to small
            let newSize = CGSize(width: 215.056, height: 214.202)
            let resizeAction = SKAction.scale(to: newSize, duration: 0.5)
            resizeAction.timingMode = .easeOut
            
            self.moonResultNode.run(resizeAction)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
               
            }
        }
        
        
        
        
        
    }
    
    
}
