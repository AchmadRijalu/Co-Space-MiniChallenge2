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
    
    //    func setupGuestTimer(){
    //        if  let planetGuide = scene?.childNode(withName: "planetGuide"){
    //
    //        }
    //    }
    
    func setupGuestList(){
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
            print(guestSpawned.firstGuestSpawned)
            guestSpawned.secondGuestSpawned = true
            print(guestSpawned.secondGuestSpawned)
            guestSpawned.thirdGuestSpawned = true
            print(guestSpawned.thirdGuestSpawned)
            
            
            
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
    
    //TAP ACTION FUNCTION
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
                print("Ini muncul ketiga")
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
            
            //Do Something
            
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
    override func didMove(to view: SKView) {
        
        setupGuestSeatNodesList()
        
        
        spawnGuestFromSecurity()
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if guestSpawned.timerState == false && guestSpawned.firstGuestSpawned == true && guestSpawned.secondGuestSpawned == true && guestSpawned.thirdGuestSpawned == true{
            
            if self.guestNodeList.count == 0{
                
            }
            //THE CODE START HERE
            else{
               
                if guestNodeList.count == 1 && guestNodeList[0].queue == 1{
                    if guestNodeList[0].position.x != locationQueue1?.position.x {
                        if let nextMovingSprite = scene?.childNode(withName: guestNodeList[0].name) {
                            if guestNodeList[0].position.x != locationQueue2?.position.x{
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
                            else{
                                let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
                                let sequenceMove = SKAction.sequence([sixthMove ])
                                let groupAction = SKAction.group([sequenceMove])
                                
                                nextMovingSprite.run(groupAction)
                            }
                            
                        }
                        
                    }
                }
              else  if guestNodeList.count == 1 && guestNodeList[0].queue == 0{
                    guestNodeList[0].position = locationQueue1!.position
                    let movingSprite = scene?.childNode(withName: guestNodeList[0].name)
                    let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
                    let sequenceMove = SKAction.sequence([ sixthMove ])
                    let groupAction = SKAction.group([sequenceMove])
                    
                    movingSprite!.run(groupAction)
                }
               else if guestNodeList.count == 2{
//                   print(guestNodeList[0].queue)
//                   print(guestNodeList[1].queue)
                   
                   
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
                        
                        var movingSprite = scene?.childNode(withName: guestNodeList[0].name)
                        let sixthMove = SKAction.move(to: locationQueue1!.position, duration: guestNodeList[0].duration)
                        let sequenceMove = SKAction.sequence([ sixthMove ])
                        let groupAction = SKAction.group([sequenceMove])
                        
                        movingSprite!.run(groupAction)
                    }
                    
                    if guestNodeList[1].queue == 2{
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
                
                else  if guestNodeList.count == 3{
                    if guestNodeList[2].queue == 3{
                       
                        if guestNodeList[2].position.x != locationQueue3?.position.x{
                            guestNodeList[2].position = locationQueue3!.position
                            var nextMovingThirdSprite = scene?.childNode(withName: guestNodeList[2].name)
                            let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[2].duration)
                            let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[2].duration)
                            let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[2].duration)
                            let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[2].duration)
                            let guestNodeFinalSize: CGFloat = 1.4
                            let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[2].duration)
                            
                            let sequenceMove = SKAction.sequence([firstMove, secondMove, fourthMove ])
                            
                            let groupAction = SKAction.group([sequenceMove, scaleAction])
                            
                            nextMovingThirdSprite!.run(groupAction)
                        }
                    }
                    else if guestNodeList[2].queue == 2{
                        if guestNodeList[2].position.x != locationQueue2!.position.x{
                            
                            guestNodeList[2].position = locationQueue3!.position
                            var nextMovingThirdSprite = scene?.childNode(withName: guestNodeList[2].name)
                            
                            let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[2].duration)
                            let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[2].duration)
                            let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[2].duration)
                            let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[2].duration)
                            
                            let guestNodeFinalSize: CGFloat = 1.4
                            let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[2].duration)
                            
                            let sequenceMove = SKAction.sequence([ fourthMove ])
                            
                            let groupAction = SKAction.group([sequenceMove, scaleAction])
                            
                            nextMovingThirdSprite!.run(groupAction)
                        }
                    }
                }
                
                let guestDraggable = self.scene?.childNode(withName: guestNodeList.first!.name)
                let randomDuration = 5.0
                let removeAction = SKAction.removeFromParent()
                let waitAction = SKAction.wait(forDuration: randomDuration)
                let sequenceAction = SKAction.sequence([waitAction, removeAction])
                let checkAction = SKAction.run {
                    if guestDraggable!.parent == nil {
                        
                        if self.guestNodeList.count != 0{
                            
                            self.guestNodeList.removeFirst()
                            print("terdelete")
                            if self.guestNodeList.count == 1{
                                self.guestNodeList[0].queue = 0
                                
                            }
                            if self.guestNodeList.count == 2{
                                print("masuk pak eko")
                                self.guestNodeList[0].queue = 0
                                self.guestNodeList[1].queue = 1
                            }
                           
                            
                            
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
