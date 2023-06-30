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
    var guest: SKNode
}

class GuiderGameScene: SKScene, ObservableObject, SKPhysicsContactDelegate{
    var planetGuide: SKNode?
    
    //Spawn Location
    var locationSpawn : SKNode?
    
    //List of Seat
    var seatTriangleNodeList: [SKNode] = []
    var seatCircleNodeList: [SKNode] = []
    var seatSquareNodeList: [SKNode] = []
    
    var guestTimer: Timer?
    var continuousTimer: Timer?
    var locationList: [SKNode] = []
    var moveLocationList: [SKNode] = []
    var queueList: [GuestQueue] = []
    
    //SET UP THE SEAT NODE
    func setupGuestSeatNodesList() {
        for i in 1...5 {
            if let guestSeatNodeTriangle = planetGuide?.childNode(withName: "triangleseat\(i)") {
                seatTriangleNodeList.append(guestSeatNodeTriangle)
            }
            if let guestSeatNodeCircle = planetGuide?.childNode(withName: "circleseat\(i)") {
                seatCircleNodeList.append(guestSeatNodeCircle)
            }
            if let guestSeatNodeSquare = planetGuide?.childNode(withName: "squareseat\(i)") {
                seatSquareNodeList.append(guestSeatNodeSquare)
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
    
    override func didMove(to view: SKView) {
        continuousTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.addGuest()
        }
    }
    
    private func addGuest(){
        if (self.queueList.count >= 3){
            // fail
            print("nyawa berkurang")
        }
        else {
            self.newGuest = generateGuest()
            self.updateNewGuest()
            self.scene?.addChild(self.newGuest!)
        }
    }
    
    private func generateGuest() -> SKNode {
        let newGuest = SKSpriteNode(texture: SKTexture(imageNamed: "guest-3"))
        newGuest.position = locationSpawn?.position ?? CGPoint(x: 0.0, y: 0.0)
        newGuest.name = "newGuest"
        newGuest.size = CGSize(width: 100, height: 100)
        let tags: NSMutableDictionary = [
            "kesabaran": 10,
        ]
        newGuest.userData = tags
        
        return newGuest
    }
    
    var seatClickable: Bool = true
    var guestLeave: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if (seatClickable){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangleseat2" {
                guestTimer?.invalidate()
                guestTimer = nil
                
                moveGuest()
            }
        }
    }
    func moveGuest() {
        self.seatClickable = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.seatClickable = true
        }
        
        if (queueList.count > 0){
            for i in 0...(queueList.count-1) {
                if (queueList[i].queue > 1){
                    let nextQueue = queueList[i].queue - 1
                    
                    // Animation jalannya
                    let moveAction = SKAction.move(to: locationList[nextQueue - 1].position, duration: 1.0)
                    queueList[i].guest.run(moveAction)
                    
                    // Perbarui queuenya yang sekarang
                    queueList[i].queue = nextQueue
                }
                else {
                    // Kalo guestnya udah dikasih tanda
                    if (!guestLeave){
                        // Udah masuk ke guide
                        let moveAction = SKAction.moveBy(x: 100, y: 100, duration: 1.0)
                        queueList[i].guest.run(moveAction)
                    }
                    else { // kalo misalnya kesabarannya udah habis
                        let moveAction = SKAction.moveBy(x: 0, y: -175, duration: 1.0)
                        queueList[i].guest.run(moveAction)
                        guestLeave = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.queueList[i].guest.removeFromParent()
                        self.queueList.removeFirst()
                    }
                }
            }
            
            let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "kesabaran") as? Int
            timerRenewal(seconds: firstQueueGuestTime ?? 0)
        }
    }
    
    private func timerRenewal(seconds: Int){
        self.guestTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { timer in
            self.guestLeave = true
            self.moveGuest()
            
            // kurangin health
            print("Waktu kesabaran habis")
        }
    }
    
    var newGuest: SKNode?
    private func updateNewGuest() {
        // Move the last queue to position 3 from spawn
        let moveAction1 = SKAction.move(to: moveLocationList[0].position, duration: 1.0)
        self.newGuest?.run(moveAction1)
//        let scaleAction = SKAction.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let moveAction2 = SKAction.move(to: self.moveLocationList[1].position, duration: 1.0)
            self.newGuest?.run(moveAction2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let moveAction3 = SKAction.move(to: self.moveLocationList[2].position, duration: 1.0)
            self.newGuest?.run(moveAction3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let moveAction4 = SKAction.move(to: self.locationList[self.queueList.count].position, duration: 1.0)
            self.newGuest?.run(moveAction4)
            
            self.queueList.append(GuestQueue(queue: (self.queueList.count + 1), guest: self.newGuest!))
            self.newGuest = nil
        }
    }
}
