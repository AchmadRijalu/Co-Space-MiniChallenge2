//
//  GameScene.swift
//  cospaceminoque
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 26/06/23.
//

import SpriteKit
import GameplayKit
import SwiftUI
import AVFoundation
    
class CleanerGameScene: SKScene {
    var game: MainGame!
    
    // Setup Scene
    var activePoop: SKSpriteNode? = nil
    var activeSeatWithPoop = ""
    var seatWithPoop: [String] = []
    let cleaningItemNodeSize = ["green": ["width": 77, "height": 156], "orange": ["width": 128, "height": 156], "brown": ["width": 110, "height": 156]]
    var drawerOpen: Bool = false
    var buttonGuessClickable: Bool = false
    var poopCleaned = AVAudioPlayer()
    var poopSpawned = AVAudioPlayer()
    
    var damageanimation: SKNode?
    let cleanerBackground = SKSpriteNode(imageNamed : "cleaner-background")
    let cleanerPlanet = SKSpriteNode(imageNamed : "cleaner-planet")
    let cleanerStorage = SKSpriteNode(imageNamed : "cleaner-storage")
    let cleanerDoorLeft = SKSpriteNode(imageNamed : "cleaner-storage-door-left")
    let cleanerDoorRight = SKSpriteNode(imageNamed : "cleaner-storage-door-right")
    let cleanerButtonMoon = SKSpriteNode(imageNamed : "cleaner-button-moon")
    let cleanerButtonSun = SKSpriteNode(imageNamed : "cleaner-button-sun")
    let cleanerButtonStar = SKSpriteNode(imageNamed : "cleaner-button-star")
    var cleanerStorageContent = SKSpriteNode()
    
    let symbol = ["square", "circle", "triangle"]
    var seatNodeList: [String:[SKNode]] = ["square": [], "circle": [], "triangle": []]
    var continuousTimer: Timer?
    
    func playPoopCleanedSoundEffect() {
        guard let url = Bundle.main.url(forResource: "poop-cleaned", withExtension: "wav") else { return }
        do {
            
            poopCleaned = try AVAudioPlayer(contentsOf: url)
            poopCleaned.numberOfLoops = 0
            poopCleaned.prepareToPlay()
            poopCleaned.play()
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    func playPoopSpawnSoundEffect() {
        guard let url = Bundle.main.url(forResource: "poop-spawn", withExtension: "wav") else { return }
        do {
            
            poopSpawned = try AVAudioPlayer(contentsOf: url)
            poopSpawned.numberOfLoops = 0
            poopSpawned.prepareToPlay()
            poopSpawned.play()
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    override func sceneDidLoad() {
        if let cleanerBackgroundNode = scene?.childNode(withName: "cleaner-background") {
            cleanerBackground.name = "cleaner-planet"
            cleanerBackground.size = CGSize(width: 1000, height: 1000)
            cleanerBackground.position = cleanerBackgroundNode.position
            cleanerBackground.zPosition = 1
            self.addChild(cleanerBackground)
        }
        
        if let cleanerPlanetNode = scene?.childNode(withName: "cleaner-planet") {
            cleanerPlanet.name = "cleaner-planet"
            cleanerPlanet.size = CGSize(width: 780, height: 400)
            cleanerPlanet.position = cleanerPlanetNode.position
            cleanerPlanet.zPosition = 2
            self.addChild(cleanerPlanet)
        }
        
        if let cleanerStorageNode = scene?.childNode(withName: "cleaner-storage") {
            cleanerStorage.name = "cleaner-storage"
            cleanerStorage.size = CGSize(width: 300, height: 400)
            cleanerStorage.position = cleanerStorageNode.position
            cleanerStorage.zPosition = 3
            self.addChild(cleanerStorage)
        }
        
        if let cleanerDoorNodeLeft = scene?.childNode(withName: "cleaner-storage-door-left") {
            cleanerDoorLeft.name = "cleaner-storage-door-left"
            cleanerDoorLeft.size = CGSize(width: 106, height: 176)
            cleanerDoorLeft.position = cleanerDoorNodeLeft.position
            cleanerDoorLeft.zPosition = 10
            cleanerDoorLeft.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            self.addChild(cleanerDoorLeft)
        }
        
        if let cleanerDoorNodeRight = scene?.childNode(withName: "cleaner-storage-door-right") {
            cleanerDoorRight.name = "cleaner-storage-door-right"
            cleanerDoorRight.size = CGSize(width: 86, height: 176)
            cleanerDoorRight.position = cleanerDoorNodeRight.position
            cleanerDoorRight.zPosition = 10
            cleanerDoorRight.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            self.addChild(cleanerDoorRight)
        }

        if let cleanerButtonMoonNode = scene?.childNode(withName: "cleaner-guess-moon") {
            cleanerButtonMoon.name = "cleaner-guess-moon"
            cleanerButtonMoon.size = CGSize(width: 30, height: 45)
            cleanerButtonMoon.position = cleanerButtonMoonNode.position
            cleanerButtonMoon.zPosition = 11
            self.addChild(cleanerButtonMoon)
        }
        
        if let cleanerButtonSunNode = scene?.childNode(withName: "cleaner-guess-sun") {
            cleanerButtonSun.name = "cleaner-guess-sun"
            cleanerButtonSun.size = CGSize(width: 30, height: 45)
            cleanerButtonSun.position = cleanerButtonSunNode.position
            cleanerButtonSun.zPosition = 11
            self.addChild(cleanerButtonSun)
        }
        
        if let cleanerButtonStarNode = scene?.childNode(withName: "cleaner-guess-star") {
            cleanerButtonStar.name = "cleaner-guess-star"
            cleanerButtonStar.size = CGSize(width: 30, height: 45)
            cleanerButtonStar.position = cleanerButtonStarNode.position
            cleanerButtonStar.zPosition = 11
            self.addChild(cleanerButtonStar)
        }
        
        if let cleanerStorageContentNode = scene?.childNode(withName: "cleaner-storage-content") {
            cleanerStorageContent.name = "cleaner-storage-content"
            cleanerStorageContent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            cleanerStorageContent.position = cleanerStorageContentNode.position
            cleanerStorageContent.zPosition = 8
            self.addChild(cleanerStorageContent)
        }
        
        if let damageanimationNode = self.scene?.childNode(withName: "damageanimation") {
            damageanimation = damageanimationNode
        }
        
        for i in 1...5 {
            if let guestSeatNodeTriangle = scene?.childNode(withName: "triangle-seat-\(i)") {
                seatNodeList["triangle"]?.append(guestSeatNodeTriangle)
                guestSeatNodeTriangle.zPosition = 5
            }
            if let guestSeatNodeCircle = scene?.childNode(withName: "circle-seat-\(i)") {
                seatNodeList["circle"]?.append(guestSeatNodeCircle)
                guestSeatNodeCircle.zPosition = 5
            }
            if let guestSeatNodeSquare = scene?.childNode(withName: "square-seat-\(i)") {
                seatNodeList["square"]?.append(guestSeatNodeSquare)
                guestSeatNodeSquare.zPosition = 5
            }
        }
    }
    
    override func didMove(to view: SKView) {
        continuousTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if (self.seatWithPoop.count < 2){
//                while true {
//                    var randomSymbolShuffled = self.symbol.shuffled()
//                    if let chosenSymbol = randomSymbolShuffled.popLast() {
//                        let randomizedSeat = "\(chosenSymbol)-seat-\(Int.random(in: 1...5))"
//                        if (!self.seatWithPoop.contains(randomizedSeat)){
//                            self.seatWithPoop.append(randomizedSeat)
//                            print("NEW SEAT WITH POOP")
//                            print(self.seatWithPoop)
//                            break
//                        }
//                    }
//                }
//            }
            
            if (self.game.newDirtySeatCleaner != nil){
                let seatSymbol = (self.game.newDirtySeatCleaner?[0])!
                let seatNumber = "\((self.game.newDirtySeatCleaner?[1])!)"
                let newDirtySeat = "\(seatSymbol)-seat-\(seatNumber)"
                print("New dirty seat: \(newDirtySeat)")
                self.seatWithPoop.append(newDirtySeat)
                self.game.newDirtySeatCleaner = nil
            }
            
            print(self.seatWithPoop)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
//        print(self.game.drawerContent)
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode {
            if (node.name != nil){
                if (node.name!.contains("seat")){
                    if (activePoop == nil && activeSeatWithPoop == ""){
                        if (seatWithPoop.contains(node.name!)) {
                            var randomPoopShuffled = self.game.cleaningItemAndPoop.shuffled()
                            if let chosenPoop = randomPoopShuffled.popLast() {
                                activePoop = SKSpriteNode(imageNamed: "cleaner-poop-\(chosenPoop)")
                                activePoop?.name = chosenPoop
                                activePoop?.position = CGPoint(x: node.position.x, y: node.position.y + 20)
                                activePoop?.size = CGSize(width: 30, height: 30)
                                activePoop?.zPosition = 10
                                self.scene?.addChild(activePoop!)
                                playPoopSpawnSoundEffect()
                                activeSeatWithPoop = node.name!
                                buttonGuessClickable = true
                                print("\(activeSeatWithPoop) : \(activePoop?.name)")
                            }
                            self.game.randomizeDrawer()
                            self.game.updatePoopState(newState: 1)
                        }
                        else {
                            damageanimationrun()
                            print("Health berkurang, salah kursi")
                        }
                    }
                }
                
                if (node.name!.contains("guess")){
                    if (activePoop != nil && activeSeatWithPoop != "" && buttonGuessClickable) {
                        buttonGuessClickable = false
                        let guessedSymbol: String = String((node.name?.split(separator: "-")[2])!) as String
                        
                        if (drawerOpen){
                            animateDrawer(open: false)
                            drawerOpen = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                self.animateDrawer(open: true)
                                self.drawerOpen = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    self.buttonGuessClickable = true
                                }
                            }
                        }
                        else {
                            animateDrawer(open: true)
                            drawerOpen = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                self.buttonGuessClickable = true
                            }
                        }
                        
                        let delay = (self.cleanerStorageContent.texture == nil) ? 0.0 : 0.7
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            self.cleanerStorageContent.texture = SKTexture(imageNamed: "cleaner-tool-\(self.game.drawerContent[guessedSymbol]!)")
                            self.cleanerStorageContent.size = CGSize(width: self.cleaningItemNodeSize[self.game.drawerContent[guessedSymbol]!]!["width"]!, height: self.cleaningItemNodeSize[self.game.drawerContent[guessedSymbol]!]!["height"]!)
                        }
                        
                        if (self.game.drawerContent[guessedSymbol] == self.activePoop?.name) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.activePoop?.run(SKAction.fadeOut(withDuration: 0.5))
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.activePoop?.removeFromParent()
                                    self.playPoopCleanedSoundEffect()
                                }
                                self.activePoop = nil
                            }
                            
                            let seatSymbol = self.activeSeatWithPoop.split(separator: "-")[0]
                            let seatNumber = Int(self.activeSeatWithPoop.split(separator: "-")[2])!
                            self.game.sendCleanedSeatToGuide(symbol: String(seatSymbol), number: seatNumber)
                            
                            self.seatWithPoop = self.seatWithPoop.filter { $0 != activeSeatWithPoop }
                            activeSeatWithPoop = ""
                            print("Poop hilang")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                self.animateDrawer(open: false)
                                self.drawerOpen = false
                                self.game.updatePoopState(newState: 2)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.cleanerStorageContent.texture = nil
                                }
                            }
                        }
                        else {
                            damageanimationrun()
                            print("Health berkurang, salah tebak")
                        }
                    }
                }
            }
        }
    }
    
    private func animateDrawer(open: Bool) {
        if (open){
            let shrinkAction = SKAction.resize(toWidth: 0.0, duration: 0.5)
            self.cleanerDoorLeft.run(shrinkAction)
            self.cleanerDoorRight.run(shrinkAction)
        }
        else {
            let growActionLeft = SKAction.resize(toWidth: 106.0, duration: 0.5)
            self.cleanerDoorLeft.run(growActionLeft)
            
            let growActionRight = SKAction.resize(toWidth: 86, duration: 0.5)
            self.cleanerDoorRight.run(growActionRight)
        }
    }
    
    //MARK: DamageAnimation
    func damageanimationrun() {
        let fadeInAction = SKAction.fadeIn(withDuration: 0.8)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.8)
        let sequence = SKAction.sequence([fadeInAction,fadeOutAction])
        damageanimation?.run(sequence)
    }
}

