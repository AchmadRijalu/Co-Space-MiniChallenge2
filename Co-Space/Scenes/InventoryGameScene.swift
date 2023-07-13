//
//  InventoryGameScene.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 28/06/23.
//

import SpriteKit
import GameplayKit
import SwiftUI
import AVFoundation

class InventoryGameScene: SKScene {
    // MARK: - Declaring as SKNode
    var game: MainGame!
    
    var inventoryBackground, inventoryLabel, inventoryShop, inventoryStorageMoon, inventoryStorageSun, inventoryStorageStar, inventoryPotionCard, inventoryTriangleCard, inventoryCircleCard, inventoryRectangleCard, inventoryStorageDoorLeft1, inventoryStorageDoorRight1, inventoryStorageDoorLeft2, inventoryStorageDoorRight2, inventoryStorageDoorLeft3, inventoryStorageDoorRight3, inventoryButtonOpen1, inventoryButtonOpen2, inventoryButtonOpen3, inventoryPoop: SKNode?
    var inventoryStorageContentMoon = SKSpriteNode(imageNamed : "cleaner-tool-brown")
    var inventoryStorageContentSun = SKSpriteNode(imageNamed : "cleaner-tool-green")
    var inventoryStorageContentStar = SKSpriteNode(imageNamed : "cleaner-tool-orange")
    
    //MARK: - Declaring sound effect avaudioplayer
    var storageDoorOpenedSoundEffect = AVAudioPlayer()
//    var gameOverSoundEffect = SKAudioNode()
    
    // MARK: - Inventory price,coin and drawer open button
    var coin1LabelNode = SKLabelNode()
    var potion1PriceLabelNode = SKLabelNode()
    var drawermoonOpen = false
    var drawersunOpen = false
    var drawerstarOpen = false
    var activePoop = false
    
    var continuousTimer: Timer?
    
    // MARK: - Inventory for inside content
    let cleaningItemNodeSize = ["green": ["width": 51, "height": 102], "orange": ["width": 79, "height": 97], "brown": ["width": 52, "height": 74]]
    let cleaningItemAndPoop = ["green", "orange", "brown"]
    
    
    func playSoundEffect(sound:String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }
        do {
            storageDoorOpenedSoundEffect = try AVAudioPlayer(contentsOf: url)
            storageDoorOpenedSoundEffect.numberOfLoops = 0
            storageDoorOpenedSoundEffect.prepareToPlay()
            storageDoorOpenedSoundEffect.play()
            
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Start the basic setup load
    override func sceneDidLoad() {
        setupObject()
    }
    
    // MARK: - DidMove code
    override func didMove(to view: SKView) {
        if let inventoryScene = SKScene(fileNamed: "InventoryGameScene") {
            let counterCoinNode = inventoryScene.childNode(withName: "counter-coins")!
            coin1LabelNode = setupLabelNode(counterCoinNode.position, "\(self.game.coin)")
            self.addChild(coin1LabelNode)
            
            let counterpotionPriceNode = inventoryScene.childNode(withName: "counter-potion-price")!
            potion1PriceLabelNode = setupLabelNode(counterpotionPriceNode.position, "\(self.game.potionPrice)")
            self.addChild(potion1PriceLabelNode)
        }
        
        self.continuousTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Health: \(self.game.health)")
            if (self.game.poopState == 1) {
                self.setColor()
            }
            if (self.game.poopState == 2) {
                let growActionLeft = SKAction.resize(toWidth: 72, duration: 0.5)
                let growActionRight = SKAction.resize(toWidth: 56.7, duration: 0.5)
                self.inventoryStorageDoorLeft1?.run(growActionLeft)
                self.inventoryStorageDoorRight1?.run(growActionRight)
                self.drawersunOpen = false
                self.inventoryStorageDoorLeft2?.run(growActionLeft)
                self.inventoryStorageDoorRight2?.run(growActionRight)
                self.drawermoonOpen = false
                self.inventoryStorageDoorLeft3?.run(growActionLeft)
                self.inventoryStorageDoorRight3?.run(growActionRight)
                self.drawerstarOpen = false
                
                self.game.updatePoopState(newState: 0)
            }
            
            if (self.game.coin >= 5) {
                self.changeImage(node: self.inventoryRectangleCard!, imageName: "inventory-rectangle-card-on")
                self.changeImage(node: self.inventoryCircleCard!, imageName: "inventory-circle-card-on")
                self.changeImage(node: self.inventoryTriangleCard!, imageName: "inventory-triangle-card-on")
            }
            else {
                self.changeImage(node: self.inventoryTriangleCard!, imageName: "inventory-triangle-card-off")
                self.changeImage(node: self.inventoryCircleCard!, imageName: "inventory-circle-card-off")
                self.changeImage(node: self.inventoryRectangleCard!, imageName: "inventory-rectangle-card-off")
            }
            
            if (self.game.coin >= self.game.potionPrice) {
                self.changeImage(node: self.inventoryPotionCard!, imageName: "inventory-potion-card-on")
            }
            else {
                self.changeImage(node: self.inventoryPotionCard!, imageName: "inventory-potion-card-off")
            }
            
            self.updaterlabel()
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
        inventoryStorageDoorLeft1 = scene?.childNode(withName: "inventory-storage-door-left-1")
        inventoryStorageDoorLeft2 = scene?.childNode(withName: "inventory-storage-door-left-2")
        inventoryStorageDoorLeft3 = scene?.childNode(withName: "inventory-storage-door-left-3")
        inventoryStorageDoorRight1 = scene?.childNode(withName: "inventory-storage-door-right-1")
        inventoryStorageDoorRight2 = scene?.childNode(withName: "inventory-storage-door-right-2")
        inventoryStorageDoorRight3 = scene?.childNode(withName: "inventory-storage-door-right-3")
        inventoryButtonOpen1 = scene?.childNode(withName: "inventory-button-open-1")
        inventoryButtonOpen2 = scene?.childNode(withName: "inventory-button-open-2")
        inventoryButtonOpen3 = scene?.childNode(withName: "inventory-button-open-3")
        
        if let inventoryStorageContentMoonNode = scene?.childNode(withName: "inventory-storage-content-moon") {
            inventoryStorageContentMoon.name = "inventory-storage-content-moon"
            inventoryStorageContentMoon.size = CGSize(width: 52, height: 74)
            inventoryStorageContentMoon.position = inventoryStorageContentMoonNode.position
            inventoryStorageContentMoon.position = inventoryStorageContentMoonNode.position
            inventoryStorageContentMoon.zPosition = 1
            self.addChild(inventoryStorageContentMoon)
        }
        
        if let inventoryStorageContentSunNode = scene?.childNode(withName: "inventory-storage-content-sun") {
            inventoryStorageContentSun.name = "inventory-storage-content-sun"
            inventoryStorageContentSun.size = CGSize(width: 51, height: 102)
            inventoryStorageContentSun.position = inventoryStorageContentSunNode.position
            inventoryStorageContentSun.position = inventoryStorageContentSunNode.position
            inventoryStorageContentSun.zPosition = 1
            self.addChild(inventoryStorageContentSun)
        }
        
        if let inventoryStorageContentStarNode = scene?.childNode(withName: "inventory-storage-content-star") {
            inventoryStorageContentStar.name = "inventory-storage-content-star"
            inventoryStorageContentStar.size = CGSize(width: 79, height: 97)
            inventoryStorageContentStar.position = inventoryStorageContentStarNode.position
            inventoryStorageContentStar.position = inventoryStorageContentStarNode.position
            inventoryStorageContentStar.zPosition = 1
            self.addChild(inventoryStorageContentStar)
        }
    }
    
    // MARK: - clicktouch code
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if (self.game.poopState == 1){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-2"{
                if(drawermoonOpen != true){
                    drawermoonOpen = true
                    drawersunOpen = false
                    drawerstarOpen = false
                     playSoundEffect(sound : "storage-door" )
                    animateDrawer(door: "moon", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
                    //                inventoryStorageContentSun.size
                }
            }
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-1"{
                if(drawersunOpen != true){
                    if(drawersunOpen != true){
                        drawersunOpen = true
                        drawerstarOpen = false
                        drawermoonOpen = false
                         playSoundEffect(sound : "storage-door" )
                        animateDrawer(door: "sun", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
                    }
                }
            }
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-button-open-3"{
                if(drawerstarOpen != true){
                    if(drawerstarOpen != true){
                        drawerstarOpen = true
                        drawersunOpen = false
                        drawermoonOpen = false
                         playSoundEffect(sound : "storage-door" )
                        animateDrawer(door: "star", moon: drawermoonOpen, sun: drawersunOpen, star: drawerstarOpen)
                    }
                }
            }
        }
        
        if (self.game.coin >= self.game.potionPrice){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "inventory-potion-card-off" {
                self.game.buyPotion()
                updaterlabel()
            }
        }
        
        if (self.game.coin >= 5){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode {
                if node.name == "inventory-triangle-card-off" {
                    self.game.buyIdentityCard(symbol: "triangle")
                    updaterlabel()
                } else if node.name == "inventory-circle-card-off" {
                    self.game.buyIdentityCard(symbol: "circle")
                    updaterlabel()
                } else if node.name == "inventory-rectangle-card-off" {
                    self.game.buyIdentityCard(symbol: "square")
                    updaterlabel()
                }
            }
        }
    }
    
    // MARK: - Change Image code
    func changeImage(node: SKNode, imageName: String) {
        if let nodeToChange = node as? SKSpriteNode {
            nodeToChange.texture = SKTexture(imageNamed: imageName)
        }
    }
    
    // MARK: - updatelabel code
    func updaterlabel() {
        coin1LabelNode.text = "\(self.game.coin)"
        potion1PriceLabelNode.text = "\(self.game.potionPrice)"
    }
    
    // MARK: - drawer animation code
    private func animateDrawer(door: String, moon: Bool, sun: Bool, star: Bool) {
        let shrinkAction = SKAction.resize(toWidth: 0.0, duration: 0.5)
        let growActionLeft = SKAction.resize(toWidth: 72, duration: 0.5)
        let growActionRight = SKAction.resize(toWidth: 56.7, duration: 0.5)
        let delay = SKAction.wait(forDuration: 3.0)
        var doorLeft: SKNode?
        var doorRight: SKNode?
        
        switch door {
        case "moon":
            doorLeft = inventoryStorageDoorLeft2
            doorRight = inventoryStorageDoorRight2
        case "sun":
            doorLeft = inventoryStorageDoorLeft1
            doorRight = inventoryStorageDoorRight1
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
            if moon {
                self.inventoryStorageDoorLeft1?.run(growActionLeft)
                self.inventoryStorageDoorRight1?.run(growActionRight)
                self.drawersunOpen = false
                self.inventoryStorageDoorLeft3?.run(growActionLeft)
                self.inventoryStorageDoorRight3?.run(growActionRight)
                self.drawerstarOpen = false
            }
            if sun {
                self.inventoryStorageDoorLeft2?.run(growActionLeft)
                self.inventoryStorageDoorRight2?.run(growActionRight)
                self.drawermoonOpen = false
                self.inventoryStorageDoorLeft3?.run(growActionLeft)
                self.inventoryStorageDoorRight3?.run(growActionRight)
                self.drawerstarOpen = false
            }
            if star {
                self.inventoryStorageDoorLeft1?.run(growActionLeft)
                self.inventoryStorageDoorRight1?.run(growActionRight)
                self.drawersunOpen = false
                self.inventoryStorageDoorLeft2?.run(growActionLeft)
                self.inventoryStorageDoorRight2?.run(growActionRight)
                self.drawermoonOpen = false
            }
            
        }
        self.run(shrinkAction)
        self.run(growDoorsAction)
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
    
    private func setColor() {
        if let colorMoon = self.game.drawerContent["moon"],  let colorSun = self.game.drawerContent["sun"], let colorStar = self.game.drawerContent["star"] {
            adjustSizeContent(colorMoon: colorMoon, colorSun: colorSun, colorStar: colorStar)
        }
    }
    
    private func adjustSizeContent(colorMoon: String, colorSun: String, colorStar: String){
        inventoryStorageContentMoon.texture = SKTexture(imageNamed: "cleaner-tool-\(colorMoon)")
        inventoryStorageContentSun.texture = SKTexture(imageNamed: "cleaner-tool-\(colorSun)")
        inventoryStorageContentStar.texture = SKTexture(imageNamed: "cleaner-tool-\(colorStar)")
        
        if let heightMoon = cleaningItemNodeSize[colorMoon]?["height"], let widthMoon = cleaningItemNodeSize[colorMoon]?["width"],
           let heightSun = cleaningItemNodeSize[colorSun]?["height"], let widthSun = cleaningItemNodeSize[colorSun]?["width"],
           let heightStar = cleaningItemNodeSize[colorStar]?["height"], let widthStar = cleaningItemNodeSize[colorStar]?["width"] {
            inventoryStorageContentMoon.size = CGSize(width: Int(widthMoon), height: Int(heightMoon))
            inventoryStorageContentSun.size = CGSize(width: Int(widthSun), height: Int(heightSun))
            inventoryStorageContentStar.size = CGSize(width: Int(widthStar), height: Int(heightStar))
        }
    }
}
