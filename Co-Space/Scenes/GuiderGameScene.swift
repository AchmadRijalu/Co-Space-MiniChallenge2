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
    
    //Spawn Location
    var locationSpawn : SKNode?
    var locationQueue3 : SKNode?
    var locationQueue2 :SKNode?
    var locationQueue1 :SKNode?
    var moveLocation1:SKNode?
    var moveLocation2:SKNode?
    var moveLocation3:SKNode?
    //seat object
    
    let guest = SKSpriteNode(imageNamed: "guest")
    var spawnGuest = SKSpriteNode()
    let guestSprite = SKSpriteNode()
    
    
    //SET UP THE SEAT NODE
    func setupGuestNodesList() {
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
    
    func setupGuestList(){
        let planetGuide = scene?.childNode(withName: "planetGuide")
        if let roadNode = planetGuide?.childNode(withName: "roadNode") {
            spawnGuest.name = "behind-guest-4"
            spawnGuest.texture = SKTexture(imageNamed: "behind-guest-4")
            spawnGuest.size = CGSize(width: 35, height: 60)
            spawnGuest.zPosition =  1
            seatTriangleNodeList[4].addChild(spawnGuest)
            spawnGuest.position = CGPoint(x: 0, y: 30)
            
//            let randomDuration = Double.random(in: 3.0...8.0)
//            let removeAction = SKAction.removeFromParent()
//            let waitAction = SKAction.wait(forDuration: randomDuration)
//            let sequenceAction = SKAction.sequence([waitAction, removeAction])
//            let checkAction = SKAction.run {
//                if self.spawnGuest.parent == nil {
//                    print("The sprite node has been removed")
//                } else {
//                    print("The sprite node is still attached")
//                }
//            }
//            let completeAction = SKAction.sequence([sequenceAction, checkAction])
//            spawnGuest.run(completeAction)
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
           
            let guestData = GuestGuiderModel(name: "guest-1", texture: SKTexture(imageNamed: "guest-1"), size: CGSize(width: 100, height: 100), position: CGPoint(x: locationSpawn!.position.x, y: locationSpawn!.position.y + 10), duration: 1.0)
            guestNodeList.append(guestData)
            
            
            guestSprite.size = CGSize(width: 50, height: 50)
            guestSprite.name = guestData.name
            guestSprite.position = guestData.position
            guestSprite.texture = guestData.texture
            guestSprite.zPosition = 2
            addChild(guestSprite)
            
      
            
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
            
            //position
            let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[0].duration)
            let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[0].duration)
            let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[0].duration)
            let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[0].duration)
            
            //size
            var guestNodeFinalSize: CGFloat = 1.4
            let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[0].duration)
            
            let sequenceMove = SKAction.sequence([firstMove, secondMove, thirdMove, fourthMove])
            
            let groupAction = SKAction.group([sequenceMove, scaleAction])
            guestSprite.run(groupAction)
        }
        if node.name == "triangleseat2"{

           //Do Something
            print("Terpencet2")
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
    
    
    
    override func sceneDidLoad() {
//        setupGuestNodesList()
        
    }
    
    

    
    
    override func didMove(to view: SKView) {
        //        spawnGuest()
//        locationSpawn
        
        
        setupGuestNodesList()
        setupGuestList()
        spawnGuestFromSecurity()
    }
    override func update(_ currentTime: TimeInterval) {
//        setGuestSeat()
        
    }
}
