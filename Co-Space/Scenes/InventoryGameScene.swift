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
//    var inventoryStorageDoorLeft: [SKNode] = []
    var inventoryStorageDoorRight: [SKNode] = []
    var inventoryStorageDoorLeft: SKNode?
    
    var isDoorOpen: Bool = false
    
    // MARK: - Buttons
    var inventoryButtonBuy: SKNode?
//    var inventoryOpenButtonNode: [SKNode] = []
    var inventoryButtonOpen: SKNode?
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
        if let inventoryStorageDoorLeftNode = scene?.childNode(withName: "inventory-storage-door-left-1") {
            inventoryStorageDoorLeft = inventoryStorageDoorLeftNode
        }
    }
    
//    override func didMove(to view: SKView) {
//        if inventoryButtonOpen{
//            
//        }
//     }
    
    func changeImage(node: SKNode, imageName: String) {
        if let nodeToChange = node as? SKSpriteNode {
            nodeToChange.texture = SKTexture(imageNamed: imageName)
        }
    }
    
    func openDoor() {
        let rotateAction = SKAction.rotate(byAngle: .pi / 2, duration: 1.0)
        inventoryStorageDoorLeft!.run(rotateAction)
        isDoorOpen = true
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        counter += 1
//        frameCounterNode?.text = counter.description
//    }
}
