
//
//  GuideScene.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 30/06/23.
//

import Foundation
import SpriteKit

struct GuestQueue {
    var queue: Int
    var guest: SKSpriteNode
}
class GuideScene: SKScene, ObservableObject, SKPhysicsContactDelegate{
    var planetGuide: SKNode?
    //Spawn Location
    var locationSpawn : SKNode?
    //List of Seat
    var seatNodeList: [String:[SKNode]] = ["triangle": [], "circle": [], "square": []]
    var seatNodeStatusList: [String:[Int]] = ["triangle": [0, 0, 0 , 0 ,0], "circle": [0,0,0,0,0], "square": [0,0,0,0,0]]
    var guestTimer: Timer?
    var continuousTimer: Timer?
    var locationList: [SKNode] = []
    var moveLocationList: [SKNode] = []
    var queueList: [GuestQueue] = []
    var newGuest: SKSpriteNode?
    var seatClickable: Bool = true
    var guestLeave: Bool = false
    var timerCount: Double = 0
    let timerBarWidth: CGFloat = 130.0 // Width of the timer bar
    let timerBarHeight: CGFloat = 15.0 // Height of the timer bar
    var timerBarNode: SKSpriteNode!
    var timerBarDuration: TimeInterval = 10
    var triangleTrigger:Bool = false
    var circleTrigger:Bool = false
    var squareTrigger:Bool = false
    //SET UP THE SEAT NODE
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
    
    private func generateGuest() -> SKSpriteNode {
        let randomNum = Int(arc4random_uniform(8)) + 1
        let newGuest = SKSpriteNode(texture: SKTexture(imageNamed: "guest-\(randomNum)"))
        newGuest.position = locationSpawn?.position ?? CGPoint(x: 0.0, y: 0.0)
        newGuest.name = "newGuest"
        newGuest.size = CGSize(width: 70, height: 70)
        let tags: NSMutableDictionary = [
            "kesabaran": 10,
            "alienType": randomNum
        ]
        newGuest.userData = tags
        
        return newGuest
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        print(self.queueList)
        if (seatClickable){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode {
                if (node.name != nil){
                    if (node.name!.contains("seat")){
                        let signSeatArr: String = String((node.name?.split(separator: "-")[0])!) as String
                        let numberSeatArr: String = String((node.name?.split(separator: "-")[2])!) as String
                        guestTimer?.invalidate()
                        print(signSeatArr)
                        print(numberSeatArr)
                        guestTimer = nil
                        
                        moveGuest(numberSeat: Int(numberSeatArr), signSeat: signSeatArr)
                    }
                }
                
//                moveGuestToSeat(numberSeat: 1-1, signSeat: "triangleseat")
            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangleseat2" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 2-1, signSeat: "triangleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangleseat3" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//                moveGuestToSeat(numberSeat: 3-1, signSeat: "triangleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangleseat4" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//                moveGuestToSeat(numberSeat: 4-1, signSeat: "triangleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangleseat5" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//                moveGuestToSeat(numberSeat: 5-1, signSeat: "triangleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circleseat1" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 1-1, signSeat: "circleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circleseat2" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 2-1, signSeat: "circleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circleseat3" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 3-1, signSeat: "circleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circleseat4" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//                print("halo")
//                moveGuestToSeat(numberSeat: 4-1, signSeat: "circleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circleseat5" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 5-1, signSeat: "circleseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "squareseat1" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 1-1, signSeat: "squareseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "squareseat2" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 2-1, signSeat: "squareseat")
//            }
//
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "squareseat3" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 3-1, signSeat: "squareseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "squareseat4" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 4-1, signSeat: "squareseat")
//            }
//            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "squareseat5" {
//                guestTimer?.invalidate()
//                guestTimer = nil
//
//                moveGuestToSeat(numberSeat: 5-1, signSeat: "squareseat")
//            }
        }
    }
    
    func checkQueue() {
        if (self.queueList.count > 0){
            for i in 0...(self.queueList.count - 1) {
//                if (self.queueList[i].queue == 0){
//                    continue
//                }
                
                let newQueue = i + 1
                if (queueList[i].queue != newQueue){
                    
                    self.queueList[i].queue = newQueue
                }
                
                let moveAction = SKAction.move(to: locationList[newQueue - 1].position, duration: 1.0)
                queueList[i].guest.run(moveAction)
            }
        }
    }
    
    func moveGuest(numberSeat:Int?, signSeat:String?) {
        self.seatClickable = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.seatClickable = true
        }
        
        if (queueList.count > 0){
            for i in 0...(queueList.count-1) {
                // Buat queue 2 & 3
                if (queueList[i].queue > 1){
                    let nextQueue = queueList[i].queue - 1
                    // Animation jalannya
                    let moveAction = SKAction.move(to: locationList[nextQueue - 1].position, duration: 1.0)
                    queueList[i].guest.run(moveAction)
                    
                    // Perbarui queuenya yang sekarang
                    queueList[i].queue = nextQueue
                }
                // Buat queue 1
                else {
                    // Kalo guestnya udah dikasih tanda
                    if (!guestLeave){
                        if (numberSeat != nil && signSeat != nil){
//                            let newTestNode = queueList[i].guest.copy() as! SKSpriteNode
                            let newTestNode = SKSpriteNode()
                            let moveToSeat = SKAction.move(to: seatNodeList[signSeat ?? ""]?[numberSeat! - 1].position ?? CGPoint(x: 0, y: 0), duration: 0.4)
//                            queueList[i].queue = 0
                            let newGuestSkin = self.queueList[i].guest.userData?.value(forKey: "alienType") as? Int
                            newTestNode.texture = queueList[i].guest.texture
                            newTestNode.position = queueList[i].guest.position
                            newTestNode.size = CGSize(width: 35, height: 55)
                            self.scene?.addChild(newTestNode)
                            newTestNode.run(moveToSeat)
                            self.queueList[i].guest.removeFromParent()
                            print("duduk")
                            
                            print(newGuestSkin!)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                self.queueList[i].guest.removeFromParent()
                                newTestNode.texture = SKTexture(imageNamed: "behind-guest-\(newGuestSkin!)")
                                
                                self.queueList.removeFirst()
                            }
                            //CHANGE THE TEXTURE
                            
//                            seatCircleNodeDict["seatcircle\(numberSeat)"] = queueList[i].guest
//                            startTimerGuestSeat(for: "seatcircle\(numberSeat)", duration: 2.0, sprite: queueList[i].guest as! SKSpriteNode)
                        }
                    }
                    else { // kalo misalnya kesabarannya udah habis
//                        let newNode = queueList[i].guest.copy() as! SKSpriteNode
                        var newNode:SKSpriteNode = SKSpriteNode()
                        newNode.texture = queueList[i].guest.texture
                        newNode.size = CGSize(width: 70, height: 70)
                        newNode.position = queueList[0].guest.position
                        self.queueList[i].guest.removeFromParent()
                        newNode.removeFromParent()
                        self.scene?.addChild(newNode)
                        runBounceAndDisappearAnimation(sprite: newNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.queueList.removeFirst()
                            self.guestLeave = false
//                            newNode.removeFromParent()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            newNode.removeFromParent()
                        }
                    }
                }
            }
            
//            for i
            if self.queueList.count > 0 {
                let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "kesabaran") as? Int
                timerRenewal(seconds: Int(firstQueueGuestTime!))
            }
        }
    }
    
    

    
    private func timerRenewal(seconds: Int){
        timerCount = 0
        self.guestTimer?.invalidate()
        self.guestTimer = nil
        updateTimerBar(progress: 100, full: 100)
        print("Timer Reset")
        
        self.guestTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.05), repeats: true) { timer in
            self.timerCount += 0.05
            
            self.updateTimerBar(progress: CGFloat(self.timerCount), full: CGFloat(seconds))
            if (self.timerCount >= Double(seconds)){
                self.guestLeave = true
                self.moveGuest(numberSeat: nil, signSeat: nil)
                
                // kurangin health
            }
        }
    }
    private func updateNewGuest() {
        var delayAddQueue = 0.0
        // Move the last queue to position 3 from spawn
        let moveAction1 = SKAction.move(to: moveLocationList[0].position, duration: 0.4)
        self.newGuest?.run(moveAction1)
        //        let scaleAction = SKAction.
        
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
                    
                    let newGuestTime = self.newGuest?.userData?.value(forKey: "kesabaran") as? Int
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.timerRenewal(seconds: newGuestTime!)
                    }
                }
                
                delayAddQueue = 3.3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayAddQueue) {
            self.queueList.append(GuestQueue(queue: (self.queueList.count + 1), guest: self.newGuest!))
            self.newGuest = nil
        }
    }
    
    func createTimerBar() {
        if let timeleftNode = scene?.childNode(withName: "timeLeft"),
           let timebarNode = scene?.childNode(withName: "timebar"){
            // Create the timer bar background
            let timerBarBackground = SKSpriteNode(imageNamed: "timebar")
            timerBarBackground.size = CGSize(width: 170, height: 38)
            timerBarBackground.position = CGPoint(x: timebarNode.position.x, y: timebarNode.position.y)
            addChild(timerBarBackground)
            timerBarNode = SKSpriteNode(imageNamed: "timebar-fill")
            timerBarNode.size = CGSize(width: timerBarWidth, height: timerBarHeight)
            timerBarNode.position = CGPoint(x: timeleftNode.position.x, y: timeleftNode.position.y)
            timerBarNode.anchorPoint = CGPoint(x: 0, y: 0.5)
            timerBarNode.zPosition = timerBarNode.zPosition + 1
            addChild(timerBarNode)
        }
    }
    
    func updateTimerBar(progress: CGFloat, full: CGFloat) {
        let newWidth = (1.0 - (Double(progress) / Double(full))) * 130
        timerBarNode.size.width = newWidth
    }
    
    
    func runBounceAndDisappearAnimation(sprite: SKNode) {
        // Bounce action
        let moveLeftAction = SKAction.moveBy(x: -100, y: 0, duration: 1.0)
        let moveRightAction = SKAction.moveBy(x: 100, y: 0, duration: 1.0)
        let bounceAction = SKAction.sequence([moveLeftAction, moveRightAction])
        let repeatBounceAction = SKAction.repeatForever(bounceAction)
        
        // Run the animation on the sprite node
        sprite.run(repeatBounceAction)
    }
    
//    func startTimerGuestSeat(for key: String, duration: TimeInterval, sprite: SKSpriteNode) {
//            // Check if the sprite exists in the dictionary
//            guard let sprite = seatCircleNodeDict[key] else {
//                return
//            }
//            // Create an SKAction to fade out the sprite
//            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
//
//            // Create a timer using DispatchQueue
//            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//                // Check if the sprite is still in the scene
//                if self.children.contains(sprite) {
//                    // Remove the sprite from the scene
////                    let newTextureGuest = SKSpriteNode(texture: SKTexture(imageNamed: "behind-guest-\(sprite.)"))
//                    sprite.name = "dirtysign"
////                    sprite.texture = SKTexture(imageNamed: "NewTexture")
//
//                    print("Sprite with key '\(key)' is removed from the scene")
//                }
//            }
//
//            // Run the fade out action on the sprite
//            sprite.run(fadeOutAction)
//        }
}
