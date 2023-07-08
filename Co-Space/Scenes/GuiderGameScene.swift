
//
//  GuideScene.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 30/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

struct GuestQueueGuide {
    var queue: Int
    var guest: SKSpriteNode
}
class GuiderGameScene: SKScene, ObservableObject, SKPhysicsContactDelegate{
    var game: MainGame?
    
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
    var moveLocationList: [SKNode] = []
    var queueList: [GuestQueueGuide] = []
    var newGuest: SKSpriteNode?
    var seatClickable: Bool = true
    var guestLeave: Bool = false
    var isTimeVibrating:Bool = false
    var timerCount: Double = 0
    let timerBarWidth: CGFloat = 130.0 // Width of the timer bar
    let timerBarHeight: CGFloat = 15.0 // Height of the timer bar
    var timerBarNode: SKSpriteNode!
    var timerBarBackground: SKSpriteNode?
    var timerBarDuration: TimeInterval = 10
    
    
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
        
        if let locationSpawnNode = self.scene?.childNode(withName: "locationSpawn") {
            locationSpawn = locationSpawnNode
        }
    }
    
    var addNewGuestTimerCount:Int = 0
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1000, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = -2
            addChild(particles)
        }
        createTimerBar()
        continuousTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.addNewGuestTimerCount += 1
            self.checkQueue()
            if (self.addNewGuestTimerCount >= 4){
                self.addGuest()
                self.addNewGuestTimerCount = 0
            }
        }
    }
    //MARK: - Adding a new guest
    private func addGuest(){
        if (self.queueList.count >= 3){
            // fail
            print("Health Reduce")
        }
        else {
            self.newGuest = generateGuest()
            self.updateNewGuest()
            
            self.scene?.addChild(self.newGuest!)
        }
    }
    //MARK: - Generate new guest node
    private func generateGuest() -> SKSpriteNode {
        let randomNum = Int(arc4random_uniform(8)) + 1
        let randomSign = arc4random_uniform(3) + 1
        let newGuest = SKSpriteNode(texture: SKTexture(imageNamed: "guest-\(randomNum)"))
        var signNewGuest = SKSpriteNode()
        signNewGuest.position.x = newGuest.position.x + 16
        signNewGuest.position.y = newGuest.position.y - 25
        signNewGuest.size = CGSize(width: 30, height: 30)
        signNewGuest.name = "newGuestSign"
        newGuest.addChild(signNewGuest)
        newGuest.position = locationSpawn?.position ?? CGPoint(x: 0.0, y: 0.0)
        newGuest.name = "newGuest"
        newGuest.size = CGSize(width: 70, height: 70)
        newGuest.zPosition = 2
        let tags: NSMutableDictionary = [
            "patience": 5,
            "alienType": randomNum,
        ]
        if randomSign == 1 {
            print("1")
            tags["sign"] = "square"
            signNewGuest.texture = SKTexture(imageNamed: "squaresign")
            
        } else if randomSign == 2 {
            print("2")
            tags["sign"] = "circle"
            signNewGuest.texture = SKTexture(imageNamed: "circlesign")
        }
        else if randomSign == 3 {
            print("3")
            tags["sign"] = "triangle"
            signNewGuest.texture = SKTexture(imageNamed: "trianglesign")
        }
        newGuest.userData = tags
        
        
        return newGuest
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
    
    //MARK: - Move the guest to doing something
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
                                    seatNodeStatusList[signSeat]?[numberSeat - 1] = 1
                                    
                                    newSpriteNode.texture = queueList[i].guest.texture
                                    newSpriteNode.position = queueList[i].guest.position
                                    newSpriteNode.size = CGSize(width: 35, height: 55)
                                    newSpriteNode.zPosition = 2
                                    self.scene?.addChild(newSpriteNode)
                                    newSpriteNode.run(moveToSeat)
                                    queueList[i].guest.removeFromParent()
                                    let randomNumChangeToDirty = Double(arc4random_uniform(7)) + 1
                                    DispatchQueue.main.asyncAfter(deadline: .now() + randomNumChangeToDirty) {
                                        self.seatNodeStatusList[signSeat]?[numberSeat - 1] = 2
                                        newSpriteNode.texture = SKTexture(imageNamed: "dirtysign")
                                        newSpriteNode.size = CGSize(width: 15, height: 45)
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
                        self.queueList[i].guest.removeFromParent()
                        newNode.removeFromParent()
                        self.scene?.addChild(newNode)
                        runBounceAndDisappearAnimation(sprite: newNode)
                        
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
    private func updateNewGuest() {
        var delayAddQueue = 0.0
        // Move the last queue to position 3 from spawn
        let moveAction1 = SKAction.move(to: moveLocationList[0].position, duration: 0.4)
        self.newGuest?.run(moveAction1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let moveAction2 = SKAction.move(to: self.moveLocationList[1].position, duration: 0.5)
            self.newGuest?.run(moveAction2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let moveAction3 = SKAction.move(to: self.moveLocationList[2].position, duration: 0.5)
            self.newGuest?.run(moveAction3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            let moveAction4 = SKAction.move(to: self.locationList[2].position, duration: 0.6)
            self.newGuest?.run(moveAction4)
            
        }
        delayAddQueue = 2.2
        if self.queueList.count <= 1 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                
                let moveAction4 = SKAction.move(to: self.locationList[1].position, duration: 0.6)
                self.newGuest?.run(moveAction4)
                
            }
            delayAddQueue = 2.7
            if self.queueList.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    
                    let moveAction5 = SKAction.move(to: self.locationList[0].position, duration: 0.6)
                    self.newGuest?.run(moveAction5)
                    
                    let newGuestTime = self.newGuest?.userData?.value(forKey: "patience") as? Int
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.timerRenewal(seconds: newGuestTime!)
                    }
                }
                
                delayAddQueue = 3.3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayAddQueue) {
            self.queueList.append(GuestQueueGuide(queue: (self.queueList.count + 1), guest: self.newGuest!))
            
            self.newGuest = nil
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
