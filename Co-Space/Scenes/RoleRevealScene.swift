//
//  Role Reveal.swift
//  Co-Space
//
//  Created by Billy Agustian Dharmawan on 01/07/23.
//

import Foundation
import SpriteKit

class RoleRevealScene: SKScene {
    var counterNext = 0
    var counterRole = 0
    var instructionArrays: [[String]] = [
        ["instruction-security-1", "instruction-security-2"],
        ["instruction-guide-1", "instruction-guide-2"],
        ["instruction-cleaner-1", "instruction-cleaner-2"],
        ["instruction-inventory-1", "instruction-inventory-2", "instruction-inventory-3"]
    ]
    lazy var currentInstruction: SKTexture = {
        return SKTexture(imageNamed: instructionArrays[counterRole][counterNext])
    }()
    let buttonNextEnableTexture = SKTexture(imageNamed: "role-reveal-button-next-unfilled")
    let buttonNextDisableTexture = SKTexture(imageNamed: "role-reveal-button-next-disabled")
    let buttonPreviousEnableTexture = SKTexture(imageNamed: "role-reveal-button-back-unfilled")
    let buttonPreviousDisableTexture = SKTexture(imageNamed: "role-reveal-button-back-disabled")
    
    override func sceneDidLoad() {
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
            let newTexture = counterNext < instructionArrays[counterRole].count - 1 ? buttonNextEnableTexture : buttonNextDisableTexture
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
        if counterNext < instructionArrays[counterRole].count - 1 {
            counterNext += 1
            currentInstruction = SKTexture(imageNamed: instructionArrays[counterRole][counterNext])
            refreshInstruction()
        }
        refreshButtonNext()
        refreshButtonPrevious()
    }
    
    func buttonPreviousClicked() {
        if counterNext > 0 {
            counterNext -= 1
            currentInstruction = SKTexture(imageNamed: instructionArrays[counterRole][counterNext])
            refreshInstruction()
        }
        refreshButtonNext()
        refreshButtonPrevious()
    }
}
