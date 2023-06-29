//
//  GameScene.swift
//  cospaceminoque
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 26/06/23.
//

import SpriteKit
import GameplayKit


    
class CleanerGameScene: SKScene {
    let cleanerBackground = SKSpriteNode(imageNamed : "cleaner-background")
    let cleanerPlanet = SKSpriteNode(imageNamed : "cleaner-planet")
    let cleanerStorage = SKSpriteNode(imageNamed : "cleaner-storage")
    let cleanerDoor = SKSpriteNode(imageNamed : "cleaner-storage-door")
    let cleanerButtonMoon = SKSpriteNode(imageNamed : "cleaner-button-moon")
    let cleanerButtonSun = SKSpriteNode(imageNamed : "cleaner-button-sun")
    let cleanerButtonStar = SKSpriteNode(imageNamed : "cleaner-button-star")
    
    override func sceneDidLoad() {
        
        if let cleanerBackgroundNode = scene?.childNode(withName: "cleaner-background") {
            cleanerBackground.name = "cleaner-planet"
            cleanerBackground.size = CGSize(width: 1000, height: 1000)
            cleanerBackground.position = cleanerBackgroundNode.position
            cleanerBackground.zPosition = -4
            self.addChild(cleanerBackground)
        }
        
        if let cleanerPlanetNode = scene?.childNode(withName: "cleaner-planet") {
            cleanerPlanet.name = "cleaner-planet"
            cleanerPlanet.size = CGSize(width: 780, height: 400)
            cleanerPlanet.position = cleanerPlanetNode.position
            cleanerPlanet.zPosition = -3
            self.addChild(cleanerPlanet)
        }
        
        if let cleanerStorageNode = scene?.childNode(withName: "cleaner-storage") {
            cleanerStorage.name = "cleaner-storage"
            cleanerStorage.size = CGSize(width: 300, height: 400)
            cleanerStorage.position = cleanerStorageNode.position
            cleanerStorage.zPosition = -2
            self.addChild(cleanerStorage)
        }
        
        if let cleanerDoorNode = scene?.childNode(withName: "cleaner-storage-door") {
            cleanerDoor.name = "cleaner-storage-door"
            cleanerDoor.size = CGSize(width: 180, height: 187)
            cleanerDoor.position = cleanerDoorNode.position
            cleanerDoor.zPosition = -1
            self.addChild(cleanerDoor)
        }

        if let cleanerButtonMoonNode = scene?.childNode(withName: "cleaner-button-moon") {
            cleanerButtonMoon.name = "cleaner-button-moon"
            cleanerButtonMoon.size = CGSize(width: 30, height: 45)
            cleanerButtonMoon.position = cleanerButtonMoonNode.position
            cleanerButtonMoon.zPosition = -1
            self.addChild(cleanerButtonMoon)
        }
        
        if let cleanerButtonSunNode = scene?.childNode(withName: "cleaner-button-sun") {
            cleanerButtonSun.name = "cleaner-button-sun"
            cleanerButtonSun.size = CGSize(width: 30, height: 45)
            cleanerButtonSun.position = cleanerButtonSunNode.position
            cleanerButtonSun.zPosition = -1
            self.addChild(cleanerButtonSun)
        }
        
        if let cleanerButtonStarNode = scene?.childNode(withName: "cleaner-button-star") {
            cleanerButtonStar.name = "cleaner-button-moon"
            cleanerButtonStar.size = CGSize(width: 30, height: 45)
            cleanerButtonStar.position = cleanerButtonStarNode.position
            cleanerButtonStar.zPosition = -1
            self.addChild(cleanerButtonStar)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
}

