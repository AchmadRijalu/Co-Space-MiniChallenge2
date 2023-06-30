//
//  InventoryGameScene.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 28/06/23.
//

import SpriteKit
import GameplayKit

class InventoryGameScene: SKScene {
    var inventoryBackground: SKNode?
    var inventoryLabel: SKNode?
    var inventoryShop: SKNode?
    var inventoryStorageMoon: SKNode?
    var inventoryStorageSun: SKNode?
    var inventoryStorageStar: SKNode?
    var inventoryPotionCard: SKNode?
    var inventoryTriangleCard: SKNode?
    var inventoryCircleCard: SKNode?
    var inventoryRectangleCard: SKNode?
    var inventoryStorageDoorLeft: [SKNode] = []
    var inventoryStorageDoorRight: [SKNode] = []
//    var inventoryStorageDoorLeft: SKNode?
    
    var isDoorOpen: Bool = false
    
    // MARK: - Buttons
    var inventoryButtonBuy: SKNode?
//    var inventoryOpenButtonNode: [SKNode] = []
    var inventoryButtonOpen: [SKNode] = []
//    var counter = 0
    
    override func sceneDidLoad() {
        setupObject()
    }
    
    func setupObject() {
        if let inventoryBackgroundNode = scene?.childNode(withName: "inventory-background") {
            inventoryBackground = inventoryBackgroundNode
        }
        if let inventoryLabelNode = scene?.childNode(withName: "inventory-label") {
            inventoryLabel = inventoryLabelNode
        }
        if let inventoryShopNode = scene?.childNode(withName: "inventory-shop") {
            inventoryShop = inventoryShopNode
        }
        if let inventoryStorageMoonNode = scene?.childNode(withName: "inventory-storage-moon") {
            inventoryStorageMoon = inventoryStorageMoonNode
        }
        if let inventoryStorageSunNode = scene?.childNode(withName: "inventory-storage-sun") {
            inventoryStorageSun = inventoryStorageSunNode
        }
        if let inventoryStorageStarNode = scene?.childNode(withName: "inventory-storage-star") {
            inventoryStorageStar = inventoryStorageStarNode
        }
        if let inventoryPotionCardNode = scene?.childNode(withName: "inventory-potion-card-off") {
            inventoryPotionCard = inventoryPotionCardNode
        }
        if let inventoryTriangleCardNode = scene?.childNode(withName: "inventory-triangle-card-off") {
            inventoryTriangleCard = inventoryTriangleCardNode
        }
        if let inventoryCircleCardNode = scene?.childNode(withName: "inventory-circle-card-off") {
            inventoryCircleCard = inventoryCircleCardNode
        }
        if let inventoryRectangleCardNode = scene?.childNode(withName: "inventory-rectangle-card-off") {
            inventoryRectangleCard = inventoryRectangleCardNode
        }
        if let inventoryButtonBuyNode = scene?.childNode(withName: "inventory-button-buy") {
            inventoryButtonBuy = inventoryButtonBuyNode
        }
        for i in 1...3 {
            if let inventoryStorageDoorLeftNode = scene?.childNode(withName: "inventory-storage-door-left-\(i)") {
                inventoryStorageDoorLeft.append(inventoryStorageDoorLeftNode)
            }
            if let inventoryStorageDoorRightNode = scene?.childNode(withName: "inventory-storage-door-right-\(i)") {
                inventoryStorageDoorRight.append(inventoryStorageDoorRightNode)
            }
            if let inventoryButtonOpenNode = scene?.childNode(withName: "inventory-button-open-\(i)") {
                inventoryButtonOpen.append(inventoryButtonOpenNode)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        resetItemShop()
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-1" {
            inventoryStorageDoorLeft[0].isHidden = true
            inventoryStorageDoorRight[0].isHidden = true
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-2" {
            inventoryStorageDoorLeft[1].isHidden = true
            inventoryStorageDoorRight[1].isHidden = true
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-3" {
            inventoryStorageDoorLeft[2].isHidden = true
            inventoryStorageDoorRight[2].isHidden = true
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-potion-card-off" {
            changeImage(node: inventoryPotionCard!, imageName: "inventory-potion-card-on")
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-triangle-card-off" {
            changeImage(node: inventoryTriangleCard!, imageName: "inventory-triangle-card-on")
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-circle-card-off" {
            changeImage(node: inventoryCircleCard!, imageName: "inventory-circle-card-on")
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-rectangle-card-off" {
            changeImage(node: inventoryRectangleCard!, imageName: "inventory-rectangle-card-on")
        }
    }
    
    func changeImage(node: SKNode, imageName: String) {
        if let nodeToChange = node as? SKSpriteNode {
            nodeToChange.texture = SKTexture(imageNamed: imageName)
        }
    }
    
    func resetItemShop() {
        changeImage(node: inventoryPotionCard!, imageName: "inventory-potion-card-off")
        changeImage(node: inventoryTriangleCard!, imageName: "inventory-triangle-card-off")
        changeImage(node: inventoryCircleCard!, imageName: "inventory-circle-card-off")
        changeImage(node: inventoryRectangleCard!, imageName: "inventory-rectangle-card-off")
    }
    
//    func openDoor() {
//        let rotateAction = SKAction.rotate(byAngle: .pi / 2, duration: 1.0)
//        inventoryStorageDoorLeft!.run(rotateAction)
//        isDoorOpen = true
//    }
    
//    override func update(_ currentTime: TimeInterval) {
//        counter += 1
//        frameCounterNode?.text = counter.description
//    }
}
