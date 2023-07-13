
//
//  GuideScene.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 30/06/23.
//

import Foundation
import SpriteKit
import AVFoundation
import SwiftUI

struct GuestQueueGuide {
    var queue: Int
    var guest: SKSpriteNode
}

class GuiderGameScene: SKScene, SKPhysicsContactDelegate{
    var game: MainGame!
    var newGuestNode: [String]?
    var spriteNode: SKSpriteNode?
    var timer1: Timer?
    
    var planetGuide: SKNode?
    //Spawn Location
    var locationSpawn : SKNode?
    //List of Seat
    var seatNodeList: [String:[SKNode]] = ["triangle": [], "circle": [], "square": []]
    var seatNodeStatusList: [String:[Int]] = ["triangle": [0, 0, 0 , 0 ,0], "circle": [0,0,0,0,0], "square": [0,0,0,0,0]]
    var currentProgress:Double = 0.0
    var currentFull:Int = 0
    var currentWidth:Double = 0.0
    var isFilled:Bool = false
    var guestTimer: Timer?
    var continuousTimer: Timer?
    var locationList: [SKNode] = []
    var stage: SKNode?
    var moveLocationList: [SKNode] = []
    var queueList: [GuestQueueGuide] = []
    var newGuestFromSecurity: SKSpriteNode?
    var newGuest: [String:SKSpriteNode] = [:]
    var seatClickable: Bool = true
    var guestLeave: Bool = false
    var isTimeVibrating:Bool = false
    var timerCount: Double = 0
    let timerBarWidth: CGFloat = 130.0 // Width of the timer bar
    let timerBarHeight: CGFloat = 15.0 // Height of the timer bar
    var timerBarNode: SKSpriteNode!
    var timerBarBackground: SKSpriteNode?
    var stagebackground = SKSpriteNode(imageNamed: "stage-1")
    var dj = SKSpriteNode(imageNamed: "alien")
    let texturestage = [ "stage-1", "stage-2", "stage-3", "stage-4"]
    var currentTextureIndex = 0
    var timerBarDuration: TimeInterval = 10
    var guestCounter = 0
    
    //MARK: - SoundEffect assets start here
    var alienSit = AVAudioPlayer()
    var alienLeave = AVAudioPlayer()
    var earnCoin = AVAudioPlayer()
    
    func playAlienSitSoundEffect() {
        guard let url = Bundle.main.url(forResource: "alien-sit", withExtension: "wav") else { return }
        do {
            
            alienSit = try AVAudioPlayer(contentsOf: url)
            alienSit.numberOfLoops = 0
            alienSit.prepareToPlay()
            self.alienSit.play()

        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    func playAlienLeaveSoundEffect() {
        guard let url = Bundle.main.url(forResource: "alien-leave", withExtension: "wav") else { return }
        do {
            
            alienLeave = try AVAudioPlayer(contentsOf: url)
            alienLeave.numberOfLoops = 0
            alienLeave.prepareToPlay()
            self.alienSit.play()

        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func playEarnCoinSoundEffect() {
        guard let url = Bundle.main.url(forResource: "earn-coins", withExtension: "wav") else { return }
        do {
            earnCoin = try AVAudioPlayer(contentsOf: url)
            earnCoin.numberOfLoops = 0
            earnCoin.volume = 0.5
            earnCoin.prepareToPlay()
            self.earnCoin.play()

        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    //MARK: - SET UP THE SEAT NODE
    func setupGuestSeatNodesList() {
        for i in 1...5 {
            if let guestSeatNodeTriangle = planetGuide?.childNode(withName: "triangle-seat-\(i)") {
                seatNodeList["triangle"]?.append(guestSeatNodeTriangle)
            }
            if let guestSeatNodeCircle = planetGuide?.childNode(withName: "circle-seat-\(i)") {
                seatNodeList["circle"]?.append(guestSeatNodeCircle)
            }
            if let guestSeatNodeSquare = planetGuide?.childNode(withName: "square-seat-\(i)") {
                seatNodeList["square"]?.append(guestSeatNodeSquare)
            }
        }
    }
    // Awal jalan
    override func sceneDidLoad() {
        planetGuide = scene?.childNode(withName: "planetGuide")
        setupGuestSeatNodesList()
        
        // Masukin location
        for i in 1...3 {
            
            if let locationNode = self.scene?.childNode(withName: "locationQueue\(i)") {
                locationList.append(locationNode)
            }
            
            if let moveLocationNode = self.scene?.childNode(withName: "moveLocation\(i)") {
                moveLocationList.append(moveLocationNode)
            }
        }
        
        if let locationStageNode = self.scene?.childNode(withName: "stageNode") as? SKSpriteNode {
            let newtexture = SKTexture(imageNamed: "stage-2")
            locationStageNode.texture = newtexture
        }
    }
    
    var timerCountNewGuest = 0
    let symbolGuest = ["square", "circle", "triangle"]
    override func didMove(to view: SKView) {
//        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeTexture), userInfo: nil, repeats: true)
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1000, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = -2
            addChild(particles)
        }
        if let stage1Node = scene?.childNode(withName: "GuiderStage") {
            stagebackground.name = "backgroundstageNode"
            stagebackground.size = CGSize(width:200, height: 120)
            stagebackground.position = stage1Node.position
            stagebackground.zPosition = 1
            self.addChild(stagebackground)
        }
        if let dj1Node = scene?.childNode(withName: "GuiderDJ") {
            dj.name = "djNode"
            dj.size = CGSize(width:20, height: 25)
            dj.position = dj1Node.position
            dj.zPosition = 2
            self.addChild(dj)
        }

        
        // CHANGE GAME PACE
//        DispatchQueue.main.asyncAfter(deadline: .now() + 120.0) {
//            self.game.patienceRangeGuide = ["start": 2, "end": 4]
//            self.game.watchingTimeRange = ["start": 7, "end": 10]
//        }
        
        if let background1stageNode = scene?.childNode(withName: "backgroundstage") {
            stage =  background1stageNode
        }
        createTimerBar()
        continuousTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.checkQueue()
            if (self.game.newGuestData.count > 0) {
                if ((self.queueList.count + self.newGuest.count) >= 3){
                    // UPDATE HEALTH
                    print("Health Reduce: Queue penuh")
                    self.game.updateHealth(add: false, amount: 1)
                }
                else {
                    self.guestCounter += 1
                    
                    let processedGuest = self.game.newGuestData[0]
                    let guestSymbol = processedGuest[0]
                    let guestImage = processedGuest[1]
                    self.newGuest["guest-\(self.guestCounter)"] = self.generateGuest(symbol: guestSymbol, imageName: guestImage)
                    self.addChild(self.newGuest["guest-\(self.guestCounter)"]!)
                    self.updateNewGuest(guestIdx: "guest-\(self.guestCounter)")
                }
                self.game.newGuestData.removeFirst()
            }
            
            if (self.guestTimer != nil && self.queueList.count <= 0){
                self.guestTimer?.invalidate()
                self.guestTimer = nil
            }
            
            if (self.game.newCleanedSeat.count > 0) {
                let processedSeat = self.game.newCleanedSeat[0]
                let seatSymbol = processedSeat[0]
                let seatNumber = (Int(processedSeat[1]))!
                self.seatNodeStatusList[seatSymbol]?[seatNumber - 1] = 0
                if let dirtyNode = self.childNode(withName: "\(seatSymbol)-\(seatNumber)-dirt") {
                    dirtyNode.removeFromParent()
                }
                print("New cleaned seat: \(seatSymbol)-\(seatNumber)-dirt")
                self.game.newCleanedSeat.removeFirst()
            }
        }
        let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentTextureIndex = (self.currentTextureIndex + 1) % self.texturestage.count
            let textureName = self.texturestage[self.currentTextureIndex]
            self.stagebackground.texture = SKTexture(imageNamed: textureName)
        }
    }
    
    //MARK: - Generate new guest node
    private func generateGuest(symbol: String, imageName: String) -> SKSpriteNode {
        let newGuestGenerated = SKSpriteNode(texture: SKTexture(imageNamed: imageName))
        newGuestGenerated.position = locationSpawn?.position ?? CGPoint(x: 100.0, y: 100.0)
        newGuestGenerated.name = "newGuest"
        newGuestGenerated.size = CGSize(width: 70, height: 70)
        newGuestGenerated.zPosition = 100
        let alienType = Int(imageName.split(separator: "-")[1])
        var signNewGuest = SKSpriteNode()
        signNewGuest.position.x = 16
        signNewGuest.position.y = -25
        signNewGuest.size = CGSize(width: 30, height: 30)
        signNewGuest.name = "newGuestSign"
        newGuestGenerated.addChild(signNewGuest)
       
        let tags: NSMutableDictionary = [
            "patience": Int.random(in: (self.game.patienceRangeGuide["start"]!)...(self.game.patienceRangeGuide["end"]!)),
            "alienType": alienType ?? 1,
            "sign": symbol
        ]
        signNewGuest.texture = SKTexture(imageNamed: "\(symbol)sign")
        newGuestGenerated.userData = tags
        
        return newGuestGenerated
    }
    //MARK: - Trigger
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if (seatClickable){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode {
                if (node.name != nil){
                    if (node.name!.contains("seat")){
                        let signSeatArr: String = String((node.name?.split(separator: "-")[0])!) as String
                        let numberSeatArr: String = String((node.name?.split(separator: "-")[2])!) as String
                        
                        moveGuest(numberSeat: Int(numberSeatArr), signSeat: signSeatArr)
                    }
                }
            }
        }
    }
    //MARK: - Checking queue
    func checkQueue() {
        if (game == nil){
            print("nil disini")
        }
        if (self.queueList.count > 0){
            for i in 0...(self.queueList.count - 1) {
                let newQueue = i + 1
                if (queueList[i].queue != newQueue){
                    self.queueList[i].queue = newQueue
                }
                let moveAction = SKAction.move(to: locationList[newQueue - 1].position, duration: 1.0)
                queueList[i].guest.run(moveAction)
            }
        }
    }
    
    //MARK: - Move the guest to do something
    func moveGuest(numberSeat: Int?, signSeat: String?) {
        
        self.seatClickable = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.seatClickable = true
        }
        if queueList.count > 0 {
            for i in 0...(queueList.count - 1) {
                if queueList[i].queue > 1 {
                    let nextQueue = queueList[i].queue - 1
                    let moveAction = SKAction.move(to: locationList[nextQueue - 1].position, duration: 1.0)
                    queueList[i].guest.run(moveAction)
                    queueList[i].queue = nextQueue
                    
                } else {
                    if !guestLeave {
                        if let numberSeat = numberSeat, let signSeat = signSeat {
                            if let list = seatNodeStatusList[signSeat] {
                                
                                let value = list[numberSeat - 1]
                                if value == 1 || value == 2 {
                                    print("Cannot insert into the seat.")
                                    self.isFilled = true
                                }
                                else if signSeat != self.queueList[i].guest.userData!.value(forKey: "sign" ) as! String{
                                    print("salah")
                                    self.isFilled = true
                                }
                                else {
                                    let newSpriteNode = SKSpriteNode()
                                    let seatSprite:CGPoint = CGPoint(x: (seatNodeList[signSeat]?[numberSeat - 1].position.x ?? .zero) + 8, y: (seatNodeList[signSeat]?[numberSeat - 1].position.y ?? .zero) - 10)
                                    let moveToSeat = SKAction.move(to: seatSprite, duration: 0.4)
                                    // Ada orangnya isi 1
                                    seatNodeStatusList[signSeat]?[numberSeat - 1] = 1
                                    newSpriteNode.texture = queueList[i].guest.texture
                                    newSpriteNode.position = queueList[i].guest.position
                                    newSpriteNode.size = CGSize(width: 35, height: 55)
                                    newSpriteNode.zPosition = 2
                                    self.addChild(newSpriteNode)
                                    //MARK: - Play Sit Sound Effect
                                    self.playAlienSitSoundEffect()
                                    
                                    newSpriteNode.run(moveToSeat)
                                    queueList[i].guest.removeFromParent()
                                    
                                    self.playEarnCoinSoundEffect()
                                    self.game.updateCoin(add: true, amount: 1)
                                    self.game.updateScore(amount: 1)
                                    
                                    let randomNumChangeToDirty = Double(Int.random(in: (self.game.watchingTimeRange["start"]!)...(self.game.watchingTimeRange["end"]!)))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + randomNumChangeToDirty) {
                                        // Kotor isi 2
                                        self.seatNodeStatusList[signSeat]?[numberSeat - 1] = 2
                                        //MARK: - Play Leave Sound Effect
                                        self.playAlienLeaveSoundEffect()
                                        newSpriteNode.texture = SKTexture(imageNamed: "dirtysign")
                                        newSpriteNode.name = "\(signSeat)-\(numberSeat)-dirt"
                                        newSpriteNode.size = CGSize(width: 15, height: 45)
                                        
                                        let moveUpAction = SKAction.moveBy(x: 0.0, y: 10.0, duration: 0.6)
                                        let moveDownAction = moveUpAction.reversed()
                                        let moveUpDownSequence = SKAction.sequence([moveUpAction, moveDownAction])
                                        let moveSequenceRepeat = SKAction.repeatForever(moveUpDownSequence)
                                        
                                        newSpriteNode.run(moveSequenceRepeat)
                                        
                                        self.game.sendDirtySeatToCleaner(symbol: signSeat, number: numberSeat)
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        let newGuestSkin = self.queueList[i].guest.userData?.value(forKey: "alienType") as? Int
                                        newSpriteNode.texture = SKTexture(imageNamed: "behind-guest-\(newGuestSkin ?? 0)")
                                        self.queueList.removeFirst()
                                        self.isFilled = false
                                    }
                                    
                                }
                            }
                        }
                    } else {
                        let angrySkin = queueList[i].guest.userData?.value(forKey: "alienType") as? Int
                        let newNode = SKSpriteNode(texture: SKTexture(imageNamed: "angry-guest-\(angrySkin ?? 0)"))
                        newNode.size = CGSize(width: 35, height: 55)
                        newNode.position = self.queueList[0].guest.position
                        newNode.zPosition = 10
                        self.queueList[i].guest.removeFromParent()
                        newNode.removeFromParent()
                        self.scene?.addChild(newNode)
                        runBounceAndDisappearAnimation(sprite: newNode)
                        
                        self.game.updateHealth(add: false, amount: 1)
                        
                        self.isTimeVibrating = true
                        if self.isTimeVibrating == true{
                            let vibrationDuration: TimeInterval = 0.1
                            let vibrationDistance: CGFloat = 10.0
                            self.vibrateSpriteAnimation(self.timerBarBackground!  , duration: vibrationDuration, distance: vibrationDistance)
                            self.vibrateSpriteAnimation(self.timerBarNode  , duration: vibrationDuration, distance: vibrationDistance)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.guestLeave = false
                            self.isTimeVibrating = false
                            self.stopVibratingSprite(self.timerBarBackground!)
                            self.stopVibratingSprite(self.timerBarNode)
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.queueList.removeFirst()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            newNode.removeFromParent()
                        }
                    }
                }
            }
            
            if self.queueList.count > 0 {
                let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "patience") as? Int
                timerRenewal(seconds: Int(firstQueueGuestTime ?? 0))
            }
        }
    }
    
    //MARK: - Renew the timer
    private func timerRenewal(seconds: Int) {
        timerCount = 0
        guestTimer?.invalidate()
        guestTimer = nil
        updateTimerBar(progress: 100, full: 100)
        
        guestTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.08), repeats: true) { timer in
            if self.isFilled == true{
     
                self.timerCount = self.currentProgress
                if self.timerCount ==  self.currentProgress{
                    self.currentProgress = 0.0
                    self.isFilled = false
                }
                self.timerCount += 0.05
               
                self.updateTimerBar(progress: CGFloat(self.timerCount), full: CGFloat(self.currentFull))
            }
            else{
                self.timerCount += 0.05
                self.updateTimerBar(progress: CGFloat(self.timerCount), full: CGFloat(seconds))
                
            }
            
            
            if self.timerCount >= Double(seconds) {
                self.guestLeave = true
                self.moveGuest(numberSeat: nil, signSeat: nil)
                self.game.updateHealth(add: false, amount: 1)
            }
        }
    }
    
    //MARK: - Create the timer sprite
    func createTimerBar() {
        if let timeleftNode = scene?.childNode(withName: "timeLeft"),
           let timebarNode = scene?.childNode(withName: "timebar"){
            // Create the timer bar background
            timerBarBackground = SKSpriteNode(imageNamed: "timebar")
            timerBarBackground?.size = CGSize(width: 170, height: 38)
            timerBarBackground?.position = CGPoint(x: timebarNode.position.x, y: timebarNode.position.y)
            addChild(timerBarBackground!)
            timerBarNode = SKSpriteNode(imageNamed: "timebar-fill")
            timerBarNode.size = CGSize(width: timerBarWidth, height: timerBarHeight)
            timerBarNode.position = CGPoint(x: timeleftNode.position.x, y: timeleftNode.position.y)
            timerBarNode.anchorPoint = CGPoint(x: 0, y: 0.5)
            timerBarNode.zPosition = timerBarNode.zPosition + 1
            addChild(timerBarNode)
        }

    }
    
    //MARK: - Change the timerbar width
    func updateTimerBar(progress: CGFloat, full: CGFloat) {
        if self.isFilled == true{
            let newWidth = (1.0 - (Double(progress) / Double(full))) * 130
            timerBarNode.size.width = newWidth
        }
        else{
            let newWidth = (1.0 - (Double(progress) / Double(full))) * 130
            self.currentProgress = Double(progress)
            self.currentFull = Int(full)
            self.currentWidth = newWidth
            timerBarNode.size.width = newWidth
        }
        
    }
    
    //MARK: - Moving animation into specific location
    private func updateNewGuest(guestIdx: String) {
        var delayAddQueue = 0.0
        // Move the last queue to position 3 from spawn
        let moveAction1 = SKAction.move(to: moveLocationList[0].position, duration: 0.4)
        self.newGuest[guestIdx]?.run(moveAction1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let moveAction2 = SKAction.move(to: self.moveLocationList[1].position, duration: 0.5)
            self.newGuest[guestIdx]?.run(moveAction2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let moveAction3 = SKAction.move(to: self.moveLocationList[2].position, duration: 0.5)
            self.newGuest[guestIdx]?.run(moveAction3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            let moveAction4 = SKAction.move(to: self.locationList[2].position, duration: 0.6)
            self.newGuest[guestIdx]?.run(moveAction4)
            
        }
        delayAddQueue = 2.2
        if self.queueList.count <= 1 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                
                let moveAction4 = SKAction.move(to: self.locationList[1].position, duration: 0.6)
                self.newGuest[guestIdx]?.run(moveAction4)
                
            }
            delayAddQueue = 2.7
            if self.queueList.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    
                    let moveAction5 = SKAction.move(to: self.locationList[0].position, duration: 0.6)
                    self.newGuest[guestIdx]?.run(moveAction5)
                    
                    let newGuestTime = self.newGuest[guestIdx]?.userData?.value(forKey: "patience") as? Int
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.timerRenewal(seconds: newGuestTime ?? 5)
                    }
                }
                
                delayAddQueue = 3.3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayAddQueue) {
            self.queueList.append(GuestQueueGuide(queue: (self.queueList.count + 1), guest: (self.newGuest[guestIdx])!))
            
            self.newGuest.removeValue(forKey: guestIdx)
        }
    }
    //MARK: - Disappear Animation
    func runBounceAndDisappearAnimation(sprite: SKNode) {
        // Bounce action
        let moveLeftAction = SKAction.moveBy(x: -100, y: 0, duration: 1.0)
        let moveRightAction = SKAction.moveBy(x: 100, y: 0, duration: 1.0)
        let bounceAction = SKAction.sequence([moveLeftAction, moveRightAction])
        let repeatBounceAction = SKAction.repeatForever(bounceAction)
        
        // Run the animation on the sprite node
        sprite.run(repeatBounceAction)
    }
    
    //MARK: Vibrate Animation
    func vibrateSpriteAnimation(_ sprite: SKNode, duration: TimeInterval, distance: CGFloat) {
        
        let moveLeftAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let moveRightAction = SKAction.moveBy(x: distance, y: 0, duration: duration)
        let vibrateAction = SKAction.sequence([moveLeftAction, moveRightAction])
        let vibrateRepeatAction = SKAction.repeatForever(vibrateAction)
        
        sprite.run(vibrateRepeatAction)
    }
    //MARK: Stop Vibrate Animation
    func stopVibratingSprite(_ sprite: SKNode) {
        sprite.removeAllActions()
    }
    
    
}
