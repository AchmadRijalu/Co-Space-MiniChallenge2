//
//  InventoryGameScene.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 28/06/23.
//

import SpriteKit
import GameplayKit


class InventoryGameScene: SKScene {
    // MARK: - Declaring as SKNode
    var game: MainGame?
    var inventoryBackground, inventoryLabel, inventoryShop, inventoryStorageMoon, inventoryStorageSun, inventoryStorageStar, inventoryPotionCard, inventoryTriangleCard, inventoryCircleCard, inventoryRectangleCard, inventoryStorageDoorLeft1, inventoryStorageDoorRight1, inventoryStorageDoorLeft2, inventoryStorageDoorRight2, inventoryStorageDoorLeft3, inventoryStorageDoorRight3, inventoryButtonBuy, inventoryButtonOpen1, inventoryButtonOpen2, inventoryButtonOpen3, inventoryContentstar, inventoryContentsun, inventoryContentmoon: SKNode?
    
    // MARK: - Inventory price,coin and drawer open button
    var potionPriceNode = 15
    var totalCoinNode = 15
    var coin1LabelNode = SKLabelNode()
    var potion1PriceLabelNode = SKLabelNode()
    var drawermoonOpen = false
    var drawersunOpen = false
    var drawerstarOpen = false
    var potionclick = false
    var triangleclick = false
    var squareclick = false
    var circleclick = false
    
    // MARK: - Inventory for inside content
    let cleaningItem = ["cleaner-tool-green", "cleaner-tool-orange", "cleaner-tool-brown"]
    var drawerContent = ["sun": "", "moon": "", "star": ""]
    let cleaningItemNodeSize = ["green": ["width": 77, "height": 156], "orange": ["width": 128, "height": 156], "brown": ["width": 110, "height": 156]]
    
    // MARK: - Start the basic setup load
    override func sceneDidLoad() {
        setupObject()
    }
    
    // MARK: - DidMove code
    override func didMove(to view: SKView) {
        if let inventoryScene = SKScene(fileNamed: "InventoryGameScene") {
            let counterCoinNode = inventoryScene.childNode(withName: "counter-coins")!
            coin1LabelNode = setupLabelNode(counterCoinNode.position, "\(totalCoinNode)")
            self.addChild(coin1LabelNode)
            
            let counterpotionPriceNode = inventoryScene.childNode(withName: "counter-potion-price")!
            potion1PriceLabelNode = setupLabelNode(counterpotionPriceNode.position, "\(potionPriceNode)")
            self.addChild(potion1PriceLabelNode)
        }
    }
    
    // MARK: - SetupObject code
    func setupObject() {
        inventoryBackground = scene?.childNode(withName: "inventory-background")
        inventoryLabel = scene?.childNode(withName: "inventory-label")
        inventoryShop = scene?.childNode(withName: "inventory-shop")
        inventoryStorageMoon = scene?.childNode(withName: "inventory-storage-moon")
        inventoryStorageSun = scene?.childNode(withName: "inventory-storage-sun")
        inventoryStorageStar = scene?.childNode(withName: "inventory-storage-star")
        inventoryPotionCard = scene?.childNode(withName: "inventory-potion-card-off")
        inventoryTriangleCard = scene?.childNode(withName: "inventory-triangle-card-off")
        inventoryCircleCard = scene?.childNode(withName: "inventory-circle-card-off")
        inventoryRectangleCard = scene?.childNode(withName: "inventory-rectangle-card-off")
        inventoryButtonBuy = scene?.childNode(withName: "inventory-button-buy")
        inventoryStorageDoorLeft1 = scene?.childNode(withName: "inventory-storage-door-left-1")
        inventoryStorageDoorLeft2 = scene?.childNode(withName: "inventory-storage-door-left-2")
        inventoryStorageDoorLeft3 = scene?.childNode(withName: "inventory-storage-door-left-3")
        inventoryStorageDoorRight1 = scene?.childNode(withName: "inventory-storage-door-right-1")
        inventoryStorageDoorRight2 = scene?.childNode(withName: "inventory-storage-door-right-2")
        inventoryStorageDoorRight3 = scene?.childNode(withName: "inventory-storage-door-right-3")
        inventoryButtonOpen1 = scene?.childNode(withName: "inventory-button-open-1")
        inventoryButtonOpen2 = scene?.childNode(withName: "inventory-button-open-2")
        inventoryButtonOpen3 = scene?.childNode(withName: "inventory-button-open-3")
        inventoryContentmoon = scene?.childNode(withName: "inventory-storage-content-moon")
        inventoryContentsun = scene?.childNode(withName: "inventory-storage-content-sun")
        inventoryContentstar = scene?.childNode(withName: "inventory-storage-content-star")
    }
    
    // MARK: - clicktouch code
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        resetItemShop()
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-1"{
            if(drawermoonOpen != true){
                drawermoonOpen = true
                animateDrawer(door: "moon", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
            }
            
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-2"{
            if(drawersunOpen != true){
                if(drawersunOpen != true){
                    drawersunOpen = true
                    animateDrawer(door: "sun", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
                }
            }
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-3"{
            if(drawerstarOpen != true){
                if(drawerstarOpen != true){
                    drawerstarOpen = true
                    animateDrawer(door: "star", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
                }
            }
        }
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-potion-card-off" {
            changeImage(node: inventoryPotionCard!, imageName: "inventory-potion-card-on")
            potionclick = true
        }
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-buy" {
            if triangleclick == true || circleclick == true || squareclick == true{
                buying(5)
            }else{
                buying(potionPriceNode)
            }
     
        }
        if let node = self.atPoint(touchLocation) as? SKSpriteNode {
            if node.name == "inventory-triangle-card-off" {
                changeImage(node: inventoryTriangleCard!, imageName: "inventory-triangle-card-on")
                triangleclick = true
            } else if node.name == "inventory-circle-card-off" {
                changeImage(node: inventoryCircleCard!, imageName: "inventory-circle-card-on")
                circleclick = true
            } else if node.name == "inventory-rectangle-card-off" {
                changeImage(node: inventoryRectangleCard!, imageName: "inventory-rectangle-card-on")
                squareclick = true
            }
        }
    }
    
    // MARK: - Change Image code
    func changeImage(node: SKNode, imageName: String) {
        if let nodeToChange = node as? SKSpriteNode {
            nodeToChange.texture = SKTexture(imageNamed: imageName)
        }
    }
    
    // MARK: - resetshop code
    func resetItemShop() {
        changeImage(node: inventoryPotionCard!, imageName: "inventory-potion-card-off")
        changeImage(node: inventoryTriangleCard!, imageName: "inventory-triangle-card-off")
        changeImage(node: inventoryCircleCard!, imageName: "inventory-circle-card-off")
        changeImage(node: inventoryRectangleCard!, imageName: "inventory-rectangle-card-off")
        potionclick = false
        circleclick = false
        squareclick = false
        triangleclick = false
    }
    
    // MARK: - updatelabel code
    func updaterlabel() {
        coin1LabelNode.text = "\(totalCoinNode)"
        potion1PriceLabelNode.text = "\(potionPriceNode)"
    }
    
    // MARK: - mechanism buy code
    func buying(_ counter: Int) {
        if totalCoinNode >= counter {
            totalCoinNode -= counter
            if counter == potionPriceNode{
                potionPriceNode += 5
            }
        }
        updaterlabel()
    }
    
    // MARK: - drawer animation code
    private func animateDrawer(door: String, moon: Bool, sun: Bool, star: Bool) {
        let shrinkAction = SKAction.resize(toWidth: 0.0, duration: 0.5)
        let growActionLeft = SKAction.resize(toWidth: 60, duration: 0.5)
        let growActionRight = SKAction.resize(toWidth: 60, duration: 0.5)
        let delay = SKAction.wait(forDuration: 3.0)
        let doorLeft: SKNode?
        let doorRight: SKNode?
        
        switch door {
        case "moon":
            doorLeft = inventoryStorageDoorLeft1
            doorRight = inventoryStorageDoorRight1
        case "sun":
            doorLeft = inventoryStorageDoorLeft2
            doorRight = inventoryStorageDoorRight2
        case "star":
            doorLeft = inventoryStorageDoorLeft3
            doorRight = inventoryStorageDoorRight3
        default:
            doorLeft = nil
            doorRight = nil
        }
        doorLeft?.run(shrinkAction)
        doorRight?.run(shrinkAction)
        let growDoorsAction = SKAction.run {
            self.inventoryStorageDoorLeft1?.run(growActionLeft)
            self.inventoryStorageDoorLeft2?.run(growActionLeft)
            self.inventoryStorageDoorLeft3?.run(growActionLeft)
            self.inventoryStorageDoorRight1?.run(growActionRight)
            self.inventoryStorageDoorRight2?.run(growActionRight)
            self.inventoryStorageDoorRight3?.run(growActionRight)
        }
        if moon && sun && star {
            let sequenceAction = SKAction.sequence([delay, growDoorsAction])
            run(sequenceAction)
            self.drawermoonOpen = false
            self.drawersunOpen = false
            self.drawerstarOpen = false
        }
    }
    
    // MARK: - setuplabel for font code
    private func setupLabelNode(_ position: CGPoint, _ text: String) -> SKLabelNode {
        let labelNode = SKLabelNode(fontNamed: "SpaceGrotesk-Bold")
        labelNode.text = text
        labelNode.fontColor = .black
        labelNode.fontSize = 12
        labelNode.position = position
        labelNode.zPosition = 2
        return labelNode
    }
    
}
