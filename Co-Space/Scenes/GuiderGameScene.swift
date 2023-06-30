//
//  GuiderGameScene.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 22/06/23.
//

import SwiftUI
import SpriteKit

class GuiderGameScene: SKScene, ObservableObject, SKPhysicsContactDelegate{
    
    
    //List of Seat
    var seatTriangleNodeList: [SKNode] = []
    var seatCircleNodeList: [SKNode] = []
    var seatSquareNodeList: [SKNode] = []
    var guestNodeList:[GuestGuiderModel] = []
    
    
    @ObservedObject var guestSpawned = GuiderGameViewModel()
    
    
    
    //Spawn Location
    var locationSpawn : SKNode?
    var locationQueue3 : SKNode?
    var locationQueue2 :SKNode?
    var locationQueue1 :SKNode?
    var moveLocation1:SKNode?
    var moveLocation2:SKNode?
    var moveLocation3:SKNode?
    
    //guest object
    var spawnGuest = SKSpriteNode()
    var guestSprite = SKSpriteNode()
    var timerSprite: SKSpriteNode?
    
    // setup system
    //    var globalVaribale = GlobalVariable()
    
    //SET UP THE SEAT NODE
    func setupGuestSeatNodesList() {
        let planetGuide = scene?.childNode(withName: "planetGuide")
        for i in 1...5 {
            if let guestSeatNodeTriangle = planetGuide?.childNode(withName: "triangleseat\(i)") {
                let clickableNode = SKShapeNode(rect: guestSeatNodeTriangle.frame)
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
    
    //SET up the timer
    
    //    func setupGuestTimer() {
    //        if  let planetGuide = scene?.childNode(withName: "planetGuide"){
    //
    //        }
    //    }
    
    // MARK: - didMove
    func setupGuestList() {
        let planetGuide = scene?.childNode(withName: "planetGuide")
        if let roadNode = planetGuide?.childNode(withName: "roadNode") {
            spawnGuest.name = "behind-guest-4"
            spawnGuest.texture = SKTexture(imageNamed: "behind-guest-4")
            spawnGuest.size = CGSize(width: 35, height: 60)
            spawnGuest.zPosition =  1
            seatTriangleNodeList[4].addChild(spawnGuest)
            spawnGuest.position = CGPoint(x: 0, y: 30)
            
            let randomDuration = Double.random(in: 3.0...8.0)
            let removeAction = SKAction.removeFromParent()
            let waitAction = SKAction.wait(forDuration: randomDuration)
            let sequenceAction = SKAction.sequence([waitAction, removeAction])
            let checkAction = SKAction.run {
                if self.spawnGuest.parent == nil {
                    print("The sprite node has been removed")
                } else {
                    print("The sprite node is still attached")
                }
            }
            let completeAction = SKAction.sequence([sequenceAction, checkAction])
            spawnGuest.run(completeAction)
        }
    }
    
    // MARK: - spawnGuestFromSecurity
    func spawnGuestFromSecurity() {
        
        if let planetGuide = self.scene?.childNode(withName: "planetGuide") {
            
            locationSpawn = self.scene?.childNode(withName: "locationSpawn")
            locationQueue3 = self.scene?.childNode(withName: "locationQueue3")
            locationQueue2 = self.scene?.childNode(withName: "locationQueue2")
            locationQueue1 = self.scene?.childNode(withName: "locationQueue1")
            moveLocation1 = self.scene?.childNode(withName: "moveLocation1")
            moveLocation2 = self.scene?.childNode(withName: "moveLocation2")
            moveLocation3 = self.scene?.childNode(withName: "moveLocation3")
            guestSpawned.firstGuestSpawned = true
            guestSpawned.secondGuestSpawned = true
            guestSpawned.thirdGuestSpawned = true
            
            
            
            //            for i in 1...3 {
            //                let guestData = GuestGuiderModel(name: "guest-\(i)", texture: SKTexture(imageNamed: "guest-\(i)"), size: CGSize(width: 100, height: 100), position: CGPoint(x: locationSpawn!.position.x, y: locationSpawn!.position.y + 10), duration: 0.4, timer: 5)
            //
            //                var spawnGuestSprite = SKSpriteNode()
            //                guestSprite = spawnGuestSprite
            //                guestSprite.size = CGSize(width: 50, height: 50)
            //                guestSprite.name = guestData.name
            //                guestSprite.position = guestData.position
            //                guestSprite.texture = guestData.texture
            //                guestSprite.zPosition = 2
            //                addChild(guestSprite)
            //                guestNodeList.append(guestData)
            //                //MOVING FROM THE BEGINNING
            //            }
            
            
            //            if guestNodeList[0].position.x != locationQueue1?.position.x {
            //                if let nextMovingSprite = scene?.childNode(withName: guestNodeList[0].name) {
            //                    let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[0].position = moveLocation1!.position
            //                    let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[1-1].position = moveLocation2!.position
            //
            //                    let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[0].position = moveLocation3!.position
            //
            //                    let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[0].position = locationQueue3!.position
            //
            //                    let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[0].position = locationQueue2!.position
            //
            //                    let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
            //                    guestNodeList[0].position = locationQueue1!.position
            //                    //size
            //                    let guestNodeFinalSize: CGFloat = 1.4
            //                    let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[0].duration)
            //
            //                    let sequenceMove = SKAction.sequence([firstMove, secondMove, thirdMove, fourthMove,fifthMove, sixthMove ])
            //
            //                    let groupAction = SKAction.group([sequenceMove, scaleAction])
            //
            //                    nextMovingSprite.run(groupAction)
            //
            //
            //
            //            }
            //            var guestDraggable = self.scene?.childNode(withName: guestNodeList.first!.name)
            //            let randomDuration = Double.random(in: 3.0...8.0)
            //            timerState = true
            //            let removeAction = SKAction.removeFromParent()
            //            let waitAction = SKAction.wait(forDuration: randomDuration)
            //            let sequenceAction = SKAction.sequence([waitAction, removeAction])
            //            let checkAction = SKAction.run {
            //                if guestDraggable!.parent == nil {
            //
            //                    self.guestNodeList.removeFirst()
            //                    let nextMovingSprite = self.scene?.childNode(withName: self.guestNodeList[0].name)
            //                    let nextMovingSecondSprite = self.scene?.childNode(withName: self.guestNodeList[1].name)
            //                    let nextMovingAction = SKAction.move(to: self.locationQueue1!.position, duration: self.guestNodeList[0].duration)
            //                    let nextMovingSecondAction = SKAction.move(to: self.locationQueue2!.position, duration: self.guestNodeList[1].duration)
            //                    self.guestNodeList[0].position = self.locationQueue1!.position
            //                    self.guestNodeList[1].position = self.locationQueue2!.position
            //                    nextMovingSprite?.run(nextMovingAction)
            //                    nextMovingSecondSprite?.run(nextMovingSecondAction)
            //                    self.timerState = false
            //                    print("Deleted")
            //                    print(self.guestNodeList)
            //
            //                } else {
            //                    print("The sprite node is still attached")
            //                }
            //            }
            //            let completeAction = SKAction.sequence([sequenceAction, checkAction])
            //            guestDraggable?.run(completeAction)
            
        }
    }
    
    func spawnRandom(){
        
    }
    
    //MARK: - TAP ACTION FUNCTION
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let pos = touch.location(in: self)
        let node = self.atPoint(pos)
        
        
        if node.name == "guest-1"{
            print("ini node gest")
        }
        if node.name == "triangleseat1"{
            //Do Something
        }
        if node.name == "triangleseat2"{
            if guestNodeList.count == 0{
                let guestData = GuestGuiderModel(name: "guest-\(1)", texture: SKTexture(imageNamed: "guest-\(1)"), size: CGSize(width: 100, height: 100), position: CGPoint(x: locationSpawn!.position.x, y: locationSpawn!.position.y + 10), duration: 0.4, timer: 5, queue: 1)
                
                var spawnGuestSprite = SKSpriteNode()
                guestSprite = spawnGuestSprite
                guestSprite.size = CGSize(width: 50, height: 50)
                guestSprite.name = guestData.name
                guestSprite.position = guestData.position
                guestSprite.texture = guestData.texture
                guestSprite.zPosition = 2
                addChild(guestSprite)
                guestNodeList.append(guestData)
            }
            else if guestNodeList.count == 1{
                let guestData = GuestGuiderModel(name: "guest-\(2)", texture: SKTexture(imageNamed: "guest-\(2)"), size: CGSize(width: 100, height: 100), position: CGPoint(x: locationSpawn!.position.x, y: locationSpawn!.position.y + 10), duration: 0.4, timer: 5, queue: 2)
                
                var spawnGuestSprite = SKSpriteNode()
                guestSprite = spawnGuestSprite
                guestSprite.size = CGSize(width: 50, height: 50)
                guestSprite.name = guestData.name
                guestSprite.position = guestData.position
                guestSprite.texture = guestData.texture
                guestSprite.zPosition = 2
                addChild(guestSprite)
                guestNodeList.append(guestData)
            }
            else if guestNodeList.count == 2{
                
                let guestData = GuestGuiderModel(name: "guest-\(3)", texture: SKTexture(imageNamed: "guest-\(3)"), size: CGSize(width: 100, height: 100), position: CGPoint(x: locationSpawn!.position.x, y: locationSpawn!.position.y + 10), duration: 0.4, timer: 5, queue: 3)
                var spawnGuestSprite = SKSpriteNode()
                guestSprite = spawnGuestSprite
                guestSprite.size = CGSize(width: 50, height: 50)
                guestSprite.name = guestData.name
                guestSprite.position = guestData.position
                guestSprite.texture = guestData.texture
                guestSprite.zPosition = 2
                addChild(guestSprite)
                guestNodeList.append(guestData)
            }
            else{
                print("Maks is 3 , health reduced")
            }
            movingGuideNode(node: guestSprite)
            
            
            
        }
        if node.name == "triangleseat3"{
            
            //Do Something
            print("Terpencet3")
        }
        if node.name == "triangleseat4"{
            
            //Do Something
            print("Terpencet4")
        }
        if node.name == "triangleseat5"{
            
            //Do Something
            print("Terpencet5")
        }
        
        
    }
    
    func movingGuideNode(node: SKSpriteNode) {
        // Perform actions on the sprite node
        if guestNodeList.count == 1 && guestNodeList[0].queue == 1{
            if let nextMovingSprite = scene?.childNode(withName: guestNodeList[0].name) {
                guestNodeList[0].position = locationQueue1!.position
                let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[0].duration)
                
                let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[0].duration)
                let guestNodeFinalSize: CGFloat = 1.4
                let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[0].duration)
                
                let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[0].duration)
                let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[0].duration)
                
                
                let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[0].duration)
                let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
                let sequenceMove = SKAction.sequence([firstMove, secondMove, thirdMove, fourthMove,fifthMove, sixthMove ])
                let groupAction = SKAction.group([sequenceMove, scaleAction])
                
                nextMovingSprite.run(groupAction)
                
            }
            
            
        }
        if guestNodeList.count == 2{
            if guestNodeList[1].position.x != locationQueue2!.position.x{
                guestNodeList[1].position = locationQueue2!.position
                var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
                let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[1].duration)
                let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[1].duration)
                let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[1].duration)
                let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[1].duration)
                let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
                let guestNodeFinalSize: CGFloat = 1.4
                let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
                let sequenceMove = SKAction.sequence([firstMove, secondMove, thirdMove, fourthMove, fifthMove ])
                let groupAction = SKAction.group([sequenceMove, scaleAction])
                nextMovingSecondSprite!.run(groupAction)
            }
            if guestNodeList[0].queue == 0{
                guestNodeList[0].position = locationQueue1!.position
                
                let movingSprite = scene?.childNode(withName: guestNodeList[0].name)
                let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
                let sequenceMove = SKAction.sequence([ sixthMove ])
                let groupAction = SKAction.group([sequenceMove])
                
                movingSprite!.run(groupAction)
            }
            
            if guestNodeList[1].queue == 2{
                
                if guestNodeList[1].position.x != locationQueue2!.position.x{
                    print("masuk")
                    guestNodeList[1].position = locationQueue2!.position
                    var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
                    
                    let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[1].duration)
                    let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[1].duration)
                    let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[1].duration)
                    let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[1].duration)
                    let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
                    let guestNodeFinalSize: CGFloat = 1.4
                    let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
                    let sequenceMove = SKAction.sequence([ firstMove, secondMove , thirdMove, fourthMove,fifthMove ])
                    let groupAction = SKAction.group([sequenceMove, scaleAction])
                    nextMovingSecondSprite!.run(groupAction)
                }
            }
            if guestNodeList[1].queue == 1{
                
                guestNodeList[1].position = locationQueue2!.position
                var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
                let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
                let guestNodeFinalSize: CGFloat = 1.4
                let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
                let sequenceMove = SKAction.sequence([ fifthMove ])
                let groupAction = SKAction.group([sequenceMove, scaleAction])
                nextMovingSecondSprite!.run(groupAction)
                
                
            }
        }
        if guestNodeList.count == 3{
            
//            guestNodeList[2].position = locationQueue3!.position
            var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[2].name)
            let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[2].duration)
            let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[2].duration)
            let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[2].duration)
            let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[2].duration)
            let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[2].duration)
            let guestNodeFinalSize: CGFloat = 1.4
            let sequenceMove = SKAction.sequence([firstMove, secondMove, thirdMove, fourthMove, fifthMove ])
            let groupAction = SKAction.group([sequenceMove])
            nextMovingSecondSprite!.run(groupAction)
            
//            if guestNodeList[0].queue == 0{
//                guestNodeList[0].position = locationQueue1!.position
//
//                let movingSprite = scene?.childNode(withName: guestNodeList[0].name)
//                let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
//                let sequenceMove = SKAction.sequence([ sixthMove ])
//                let groupAction = SKAction.group([sequenceMove])
//
//                movingSprite!.run(groupAction)
//            }
            
//            if guestNodeList[1].queue == 2{
//
//                if guestNodeList[1].position.x != locationQueue2!.position.x{
//                    print("masuk")
//                    guestNodeList[1].position = locationQueue2!.position
//                    var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
//
//                    let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[1].duration)
//                    let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[1].duration)
//                    let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[1].duration)
//                    let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[1].duration)
//                    let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
//                    let guestNodeFinalSize: CGFloat = 1.4
//                    let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
//                    let sequenceMove = SKAction.sequence([ firstMove, secondMove , thirdMove, fourthMove,fifthMove ])
//                    let groupAction = SKAction.group([sequenceMove, scaleAction])
//                    nextMovingSecondSprite!.run(groupAction)
//                }
//            }
//            if guestNodeList[1].queue == 1{
//
//                guestNodeList[1].position = locationQueue2!.position
//                var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
//                let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
//                let guestNodeFinalSize: CGFloat = 1.4
//                let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
//                let sequenceMove = SKAction.sequence([ fifthMove ])
//                let groupAction = SKAction.group([sequenceMove, scaleAction])
//                nextMovingSecondSprite!.run(groupAction)
//
//
//            }
        }
        
        // ...
    }
    
    // MARK: - didMove
    override func didMove(to view: SKView) {
        
        setupGuestSeatNodesList()
        spawnGuestFromSecurity()
    }
    
    
    
    
    // MARK: - update
    override func update(_ currentTime: TimeInterval) {
        
        
        // cek perubahan data
        /* if ada perubahan perubahan dari global variable {
         spawnGuest() }
         */
        
        if guestSpawned.timerState == false && guestSpawned.firstGuestSpawned == true && guestSpawned.secondGuestSpawned == true && guestSpawned.thirdGuestSpawned == true{
            
            if self.guestNodeList.count == 0{
                
            }
            //THE CODE START HERE
            else{
                let guestDraggable = self.scene?.childNode(withName: guestNodeList.first!.name)
                let randomDuration = 5.0
                let removeAction = SKAction.removeFromParent()
                let waitAction = SKAction.wait(forDuration: randomDuration)
                let sequenceAction = SKAction.sequence([waitAction, removeAction])
                let checkAction = SKAction.run {
                    if guestDraggable!.parent == nil {
                        
                        if self.guestNodeList.count != 0{
                            
                            self.guestNodeList.removeFirst()
                            
                        }
                    } else {
                        print("The sprite node is still attached")
                    }
                }
                let completeAction = SKAction.sequence([sequenceAction, checkAction])
                guestDraggable?.run(completeAction)
                
            }
            
        }
        else {
            
        }
    }
    
    
    
    
}
