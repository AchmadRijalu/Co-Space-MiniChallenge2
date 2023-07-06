//
//  MainMenuGameScene.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 29/06/23.
//

import Foundation
import SpriteKit

class MainMenuGameScene: SKScene, SKPhysicsContactDelegate {
    var game: MainGame?
    
    override func didMove(to view: SKView) {
        
    }
    
    // Implement the necessary SKPhysicsContactDelegate methods, if needed
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle other touch events in the scene, if needed
        if let draggableSpriteNode = self.childNode(withName: "planeSliderNode") {
            
            
            print(draggableSpriteNode)
        }
        
        if let destinationSpriteNode = self.childNode(withName: "planeSlider2Node") {
            
            
            if let touch = touches.first, destinationSpriteNode.frame.contains(touch.location(in: self)) {
                // Perform scene transition or any other actions
//                let newScene = SecurityGameScene(size: self.size) // Initialize your new scene
//                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5) // Set the transition effect
//                self.scene?.view?.presentScene(newScene, transition: transition) // Change the scene
                game?.createRoom()
            }
        }
        
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle other touch events in the scene, if needed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle other touch events in the scene, if needed
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle other touch events in the scene, if needed
    }
}





