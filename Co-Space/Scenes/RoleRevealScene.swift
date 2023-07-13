//
//  Role Reveal.swift
//  Co-Space
//
//  Created by Billy Agustian Dharmawan on 01/07/23.
//

import Foundation
import SpriteKit
import SwiftUI
import AVFoundation
class RoleRevealScene: SKScene {
    var game: MainGame?
    
    var counterNext = 0
    var instructionArrays: [String: [String]] = [
        "security": ["instruction-security-1", "instruction-security-2"],
        "guide": ["instruction-guide-1", "instruction-guide-2"],
        "cleaner": ["instruction-cleaner-1", "instruction-cleaner-2"],
        "inventory": ["instruction-inventory-1", "instruction-inventory-2", "instruction-inventory-3"]
    ]
    var currentInstruction: SKTexture = SKTexture()
    let buttonNextEnableTexture = SKTexture(imageNamed: "role-reveal-button-next-unfilled")
    let buttonNextDisableTexture = SKTexture(imageNamed: "role-reveal-button-next-disabled")
    let buttonPreviousEnableTexture = SKTexture(imageNamed: "role-reveal-button-back-unfilled")
    let buttonPreviousDisableTexture = SKTexture(imageNamed: "role-reveal-button-back-disabled")
    
    var timerCountDownSoundEffect = SKAudioNode()
    
    override func sceneDidLoad() {
        refreshInstruction()
    }
    
    override func didMove(to view: SKView) {
        if let musicURL = Bundle.main.url(forResource: "count-down-15-second", withExtension: "wav") {
            self.timerCountDownSoundEffect = SKAudioNode(url: musicURL)
            self.timerCountDownSoundEffect.autoplayLooped = false
            self.addChild(timerCountDownSoundEffect)
            self.timerCountDownSoundEffect.run(SKAction.sequence([
                SKAction.run {
                    // this will start playing the pling once.
                    self.timerCountDownSoundEffect.run(SKAction.play())
                }
            ])
            )
        }
        currentInstruction = SKTexture(imageNamed: instructionArrays[game?.myRole ?? "security"]?[counterNext] ?? "instruction-security-1")
        if let roleRevealNode = self.childNode(withName: "role-reveal") as? SKSpriteNode {
            roleRevealNode.texture = SKTexture(imageNamed: "role-reveal-\(game?.myRole ?? "security")")
        }
        
        refreshInstruction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let buttonNode = touchedNode as? SKSpriteNode, buttonNode.name == "Next" {
                buttonNextClicked()
            }
            if let buttonNode = touchedNode as? SKSpriteNode, buttonNode.name == "Previous" {
                buttonPreviousClicked()
            }
        }
    }
    
    func refreshInstruction() {
        if let instructionNode = self.childNode(withName: "Instruction") as? SKSpriteNode {
            instructionNode.texture = currentInstruction
        }
    }
    
    func refreshButtonNext() {
        if let buttonNextNode = self.childNode(withName: "Next") as? SKSpriteNode {
            let newTexture = counterNext < instructionArrays[game?.myRole ?? "security"]!.count - 1 ? buttonNextEnableTexture : buttonNextDisableTexture
            buttonNextNode.texture = newTexture
        }
    }
    
    func refreshButtonPrevious() {
        if let buttonPreviousNode = self.childNode(withName: "Previous") as? SKSpriteNode {
            let newTexture = counterNext > 0 ? buttonPreviousEnableTexture : buttonPreviousDisableTexture
            buttonPreviousNode.texture = newTexture
        }
    }
    
    func buttonNextClicked() {
        if counterNext < instructionArrays[game?.myRole ?? "security"]!.count - 1 {
            counterNext += 1
            currentInstruction = SKTexture(imageNamed: instructionArrays[game?.myRole ?? "security"]![counterNext])
            refreshInstruction()
        }
        refreshButtonNext()
        refreshButtonPrevious()
    }
    
    func buttonPreviousClicked() {
        if counterNext > 0 {
            counterNext -= 1
            currentInstruction = SKTexture(imageNamed: instructionArrays[game?.myRole ?? "security"]![counterNext])
            refreshInstruction()
        }
        refreshButtonNext()
        refreshButtonPrevious()
    }
}
