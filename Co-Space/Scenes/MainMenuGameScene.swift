//
//  MainMenuGameScene.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 29/06/23.
//

import Foundation
import SpriteKit

class MainMenuGameScene: SKScene, SKPhysicsContactDelegate {
    
    var planeSliderNode: SKSpriteNode!
    var isTapped:Bool = false
    var mainMenuLabelNode : SKSpriteNode!
    let defaultPositionX:CGFloat = -98.107
    let minDragX: CGFloat = -98.107  // Batas minimum sumbu X
    let maxDragX: CGFloat = 105  // Batas maksimum sumbu X
    
    override func didMove(to view: SKView) {
        
        if let planeSliderNode = self.childNode(withName: "planeSliderNode"){
            self.planeSliderNode = planeSliderNode as? SKSpriteNode
            self.planeSliderNode.name = "planeSliderNode"
            self.planeSliderNode.position = planeSliderNode.position
            self.planeSliderNode.size = planeSliderNode.frame.size
            self.planeSliderNode.zPosition = planeSliderNode.zPosition
        }
        if let mainMenuLabelNode = self.childNode(withName: "mainMenuLabelNode"){
            self.mainMenuLabelNode = mainMenuLabelNode as! SKSpriteNode
            self.mainMenuLabelNode.name = "mainMenuLabelNode"
            self.mainMenuLabelNode.position = mainMenuLabelNode.position
            self.mainMenuLabelNode.size = mainMenuLabelNode.frame.size
            self.mainMenuLabelNode.zPosition = mainMenuLabelNode.zPosition
            
            let scaleUpAction = SKAction.scale(to: 0.6, duration: 1.0)
            let scaleDownAction = SKAction.scale(to: 0.5, duration: 1.0)
            let fadeOutAction = SKAction.fadeAlpha(to: 0.3, duration: 1.0)
            let fadeInAction = SKAction.fadeAlpha(to: 1.0, duration: 1.0)

            let pulseAction = SKAction.repeatForever(SKAction.sequence([scaleUpAction, scaleDownAction]))
            let fadeAction = SKAction.repeatForever(SKAction.sequence([fadeOutAction, fadeInAction]))

            self.mainMenuLabelNode.run(pulseAction)
            self.mainMenuLabelNode.run(fadeAction)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "planeSliderNode" {
                    self.planeSliderNode = node as? SKSpriteNode
                    
                }
//                if node.name == "mainMenuLabelNode"{
//                    print("pencet label")
//                }
            }
        }
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = self.planeSliderNode else { return }
        
        let touchLocation = touch.location(in: self)
        let draggablePosition = min(max(touchLocation.x, minDragX), maxDragX)
        node.position.x = draggablePosition
        
        if node.position.x > -7 {
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
            mainMenuLabelNode.run(SKAction.group([fadeOutAction]))
            mainMenuLabelNode.isHidden = true
        } else {
            let fadeInAction = SKAction.fadeIn(withDuration: 0.1)
            mainMenuLabelNode.alpha = 0.0
            mainMenuLabelNode.run(SKAction.group([fadeInAction]))
           
        }
        
        if node.position.x > 98.6 {
            let newScene = SecurityGameScene(size: self.size) // Initialize your new scene
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5) // Set the transition effect
            self.scene?.view?.presentScene(newScene, transition: transition) // Change the scene
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = self.planeSliderNode else { return }
        
        let touchLocation = touch.location(in: self)
        let draggablePosition = min(max(touchLocation.x, minDragX), maxDragX)
        
      
            // User didn't drag the sprite, move it back to default position
            let moveBackAction = SKAction.move(to: CGPoint(x: defaultPositionX, y: node.position.y), duration: 0.1)
            node.run(moveBackAction)
        mainMenuLabelNode.isHidden = false
        
    }

    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle other touch events in the scene, if needed
    }
}





