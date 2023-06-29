//
//  GameScene.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 21/06/23.
//

import SpriteKit
import GameplayKit

class SecurityGameScene: SKScene {
    
    let securitybackground = SKSpriteNode(imageNamed : "security-background 1")
    let planetbackground = SKSpriteNode(imageNamed : "security-planet")
    let health = SKSpriteNode(imageNamed : "health-bar")
    let healthleft = SKSpriteNode(imageNamed : "life-bar-fill")
    let timer = SKSpriteNode(imageNamed: "time-bar")
    let timeleft = SKSpriteNode(imageNamed: "time-bar-fill")
    let rectangle = SKSpriteNode(imageNamed : "button-rectangle")
    let rectangleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let circle = SKSpriteNode(imageNamed : "button-circle")
    let circleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let triangle = SKSpriteNode(imageNamed : "button-triangle")
    let triangleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    var pengunjung1 = SKSpriteNode(imageNamed : "guest-1")
    var pengunjung2 = SKSpriteNode(imageNamed : "guest-2")
    var pengunjung3 = SKSpriteNode(imageNamed : "guest-3")
    var pengunjung4 = SKSpriteNode(imageNamed : "guest-4")
    var pengunjung5 = SKSpriteNode(imageNamed : "guest-5")
    let generatepengunjung = SKSpriteNode(imageNamed : "guest-6")
    
    // MARK: - Object UI Prep
    var rectangle1textNode = SKNode()
    var rectangle1TextLabelNode = SKLabelNode()
    var triangle1textNode = SKNode()
    var triangle1TextLabelNode = SKLabelNode()
    var circle1textNode = SKNode()
    var circle1TextLabelNode = SKLabelNode()
    var counterrectangle = 10
    var countertriangle = 10
    var countercircle = 10
    var counterspawn = 0
    var uniqueID = 1
    
    override func sceneDidLoad() {
        if let securityScene = SKScene(fileNamed: "SecurityGameScene") {
            
            if let security1backgroundNode = securityScene.childNode(withName: "securitybackground") {
                securitybackground.name = "securitybackgroundNode"
                securitybackground.size = CGSize(width: UIScreen.main.bounds.width + 0.5 * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                securitybackground.position = security1backgroundNode.position
                securitybackground.zPosition = -3
                self.addChild(securitybackground)
            }
            
            if let planet1backgroundNode = securityScene.childNode(withName: "planetbackground") {
                planetbackground.name = "planetbackgroundNode"
                planetbackground.size = CGSize(width:700, height: 350)
                planetbackground.position = planet1backgroundNode.position
                planetbackground.zPosition = -1
                self.addChild(planetbackground)
            }
            
            if let timebarNode = securityScene.childNode(withName: "timebar") {
                timer.name = "timerbarNode"
                timer.size = CGSize(width: 170, height: 38)
                timer.position = timebarNode.position
                timer.zPosition = 1
                self.addChild(timer)
            }
            
            if let timeleftNode = securityScene.childNode(withName: "timeleft") {
                timeleft.name = "timerleftNode"
                timeleft.size = CGSize(width: 130, height: 15)
                timeleft.position = timeleftNode.position
                timeleft.zPosition = 2
                self.addChild(timeleft)
            }
            
            if let healthbarNode = securityScene.childNode(withName: "healthbar") {
                health.name = "healthleftNode"
                health.size = CGSize(width: 170, height: 38)
                health.position = healthbarNode.position
                health.zPosition = 1
                self.addChild(health)
            }
            
            if let healthleftNode = securityScene.childNode(withName: "healthleft") {
                healthleft.name = "timerbarNode"
                healthleft.size = CGSize(width: 130, height: 15)
                healthleft.position = healthleftNode.position
                healthleft.zPosition = 2
                self.addChild(healthleft)
            }
            
            if let rectangle1buttonNode = securityScene.childNode(withName: "rectanglebutton") {
                rectangle.name = "rectangle1buttonNode"
                rectangle.size = CGSize(width: 65, height: 80)
                rectangle.position = rectangle1buttonNode.position
                rectangle.zPosition = 1
                self.addChild(rectangle)
            }
            
            if let rectangle1quantityNode = securityScene.childNode(withName: "rectangleleft") {
                rectangleidentitycardquantity.name = "rectangle1quantityNode"
                rectangleidentitycardquantity.size = CGSize(width: 50, height: 30)
                rectangleidentitycardquantity.position = rectangle1quantityNode.position
                rectangleidentitycardquantity.zPosition = 1
                self.addChild(rectangleidentitycardquantity)
            }
            
            if let triangle1buttonNode = securityScene.childNode(withName: "trianglebutton") {
                triangle.name = "triangle1buttonNode"
                triangle.size = CGSize(width: 65, height: 80)
                triangle.position = triangle1buttonNode.position
                triangle.zPosition = 1
                self.addChild(triangle)
            }
            
            if let triangle1quantityNode = securityScene.childNode(withName: "triangleleft") {
                triangleidentitycardquantity.name = "triangle1quantityNode"
                triangleidentitycardquantity.size = CGSize(width: 50, height: 30)
                triangleidentitycardquantity.position = triangle1quantityNode.position
                triangleidentitycardquantity.zPosition = 1
                self.addChild(triangleidentitycardquantity)
            }
            
            if let circle1buttonNode = securityScene.childNode(withName: "circlebutton") {
                circle.name = "circle1buttonNode"
                circle.size = CGSize(width: 65, height: 80)
                circle.position = circle1buttonNode.position
                circle.zPosition = 1
                self.addChild(circle)
            }
            
            if let circle1quantityNode = securityScene.childNode(withName: "circleleft") {
                circleidentitycardquantity.name = "circle1quantityNode"
                circleidentitycardquantity.size = CGSize(width: 50, height: 30)
                circleidentitycardquantity.position = circle1quantityNode.position
                circleidentitycardquantity.zPosition = 1
                self.addChild(circleidentitycardquantity)
            }
            
            if let location1Node = securityScene.childNode(withName: "location1") {
                pengunjung1.name = "pengunjung1"
                pengunjung1.size = CGSize(width: 100, height: 100)
                pengunjung1.position = location1Node.position
                pengunjung1.zPosition = 1
                self.addChild(pengunjung1)
            }
            
            if let location2Node = securityScene.childNode(withName: "location2") {
                pengunjung2.name = "pengunjung2"
                pengunjung2.size = CGSize(width: 100, height: 100)
                pengunjung2.position = location2Node.position
                pengunjung2.zPosition = 1
                self.addChild(pengunjung2)
            }
            
            if let location3Node = securityScene.childNode(withName: "location3") {
                pengunjung3.name = "pengunjung3"
                pengunjung3.size = CGSize(width: 100, height: 100)
                pengunjung3.position = location3Node.position
                pengunjung3.zPosition = 1
                self.addChild(pengunjung3)
            }
            
            if let location4Node = securityScene.childNode(withName: "location4") {
                pengunjung4.name = "pengunjung4"
                pengunjung4.size = CGSize(width: 100, height: 100)
                pengunjung4.position = location4Node.position
                pengunjung4.zPosition = 1
                self.addChild(pengunjung4)
            }
            
            if let location5Node = securityScene.childNode(withName: "location5") {
                pengunjung5.name = "pengunjung5"
                pengunjung5.size = CGSize(width: 100, height: 100)
                pengunjung5.position = location5Node.position
                pengunjung5.zPosition = 1
                self.addChild(pengunjung5)
            }
        }
    }
    
    func addGuest(_amount:Int){
        if let securityScene = SKScene(fileNamed: "SecurityGameScene"),
           let spawn1Node = securityScene.childNode(withName: "spawnLocation")
        {
            let generate = SKAction.run {
                let giveGuest = GeneratePengunjung().generatePengunjung()
                spawn1Node.addChild(giveGuest)
            }
            let sequence = SKAction.sequence([generate])
            let repeatAction = SKAction.repeat(sequence, count: 1)
            self.run(repeatAction)
            if spawn1Node.children.isEmpty {
                // The parent node does not have any child nodes
                print("No child nodes present.")
            } else {
                // The parent node has child nodes
                print("Child nodes present.")
            }
        }
    }
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1000, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = -2
            addChild(particles)
        }
        if let securityScene = SKScene(fileNamed: "SecurityGameScene"){
            rectangle1textNode = securityScene.childNode(withName: "rectangletext")!
            let rectangletext = SKLabelNode(fontNamed: "Arial")
            rectangletext.text = "x\(counterrectangle)"
            rectangletext.fontColor = .black
            rectangletext.fontSize = 12
            rectangletext.position = rectangle1textNode.position
            rectangletext.zPosition = 2
            rectangle1TextLabelNode = rectangletext
            self.addChild(rectangletext)
            
            triangle1textNode = securityScene.childNode(withName: "triangletext")!
            let triangletext = SKLabelNode(fontNamed: "Arial")
            triangletext.text = "x\(countertriangle)"
            triangletext.fontColor = .black
            triangletext.fontSize = 12
            triangletext.position = triangle1textNode.position
            triangletext.zPosition = 2
            triangle1TextLabelNode = triangletext
            self.addChild(triangletext)
            
            circle1textNode = securityScene.childNode(withName: "circletext")!
            let circletext = SKLabelNode(fontNamed: "Arial")
            circletext.text = "x\(countercircle)"
            circletext.fontColor = .black
            circletext.fontSize = 12
            circletext.position = circle1textNode.position
            circletext.zPosition = 2
            circle1TextLabelNode = circletext
            self.addChild(circletext)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "rectangle1buttonNode" {
            FunctionJalan()
            counterrectangle -= 1
            
            // update di Node Label nya
            updateCounterUI(counterrectangle)
        }
        
        else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circle1buttonNode" {
            FunctionJalan()
            countercircle -= 1
            
            // update di Node Label nya
            updateCounterUI2(countercircle)
        }
        
        else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangle1buttonNode" {
            FunctionJalan()
            countertriangle -= 1
            
            // update di Node Label nya
            updateCounterUI1(countertriangle)
        }
    }
    
    func FunctionJalan() {
        
        if let securityScene = SKScene(fileNamed: "SecurityGameScene"),
           let location1Node = securityScene.childNode(withName: "location1"),
           let disappearNode = securityScene.childNode(withName: "disappearLocation"),
           let location2Node = securityScene.childNode(withName: "location2"),
           let location3Node = securityScene.childNode(withName: "location3"),
           let location4Node = securityScene.childNode(withName: "location4"),
           let location5Node = securityScene.childNode(withName: "location5"),
           let pengunjung1 = self.childNode(withName: "pengunjung1"),
           case let position1 = pengunjung1.position, position1 == location1Node.position {
            let destinationPositions = [disappearNode.position, location1Node.position, location2Node.position, location3Node.position, location4Node.position, location5Node.position]
            let moveActions = destinationPositions.map { SKAction.move(to: $0, duration: 1.0) }
            let childNodeCompletionAction = SKAction.run {
                pengunjung1.removeFromParent()
                let nodesToMove = [self.pengunjung2, self.pengunjung3, self.pengunjung4, self.pengunjung5, self.pengunjung1]
                for (index, node) in nodesToMove.enumerated() {
                    node.run(moveActions[index + 1])
                }
                let spawnLocationNodes = [self.pengunjung1]
                for node in spawnLocationNodes {
                    node.run(moveActions.last!)
                }
                
                // Remove the node from all of its ancestors
                var parentNode = pengunjung1.parent
                while parentNode != nil {
                    parentNode?.removeChildren(in: [pengunjung1])
                    parentNode = parentNode?.parent
                    
                }
            }
            let childNodeSequence = SKAction.sequence([moveActions[0], childNodeCompletionAction])
            pengunjung1.run(childNodeSequence)
        }
        
        else if let securityScene = SKScene(fileNamed: "SecurityGameScene"),
                let location1Node = securityScene.childNode(withName: "location1"),
                let disappearNode = securityScene.childNode(withName: "disappearLocation"),
                let location2Node = securityScene.childNode(withName: "location2"),
                let location3Node = securityScene.childNode(withName: "location3"),
                let location4Node = securityScene.childNode(withName: "location4"),
                let location5Node = securityScene.childNode(withName: "location5"),
                let spawn1Node = securityScene.childNode(withName: "spawnLocation"),
                let pengunjung2 = self.childNode(withName: "pengunjung2"),
                case let position1 = pengunjung2.position, position1 == location1Node.position {
            addGuest(_amount: 1)
            if spawn1Node.children.isEmpty {
                // The parent node does not have any child nodes
                print("No child nodes present.")
            } else {
                // The parent node has child nodes
                print("Child nodes present.")
            }
        }
    }
    
    
    func updateCounterUI(_ counter: Int) {
        rectangle1TextLabelNode.text = "x \(counter)"
    }
    func updateCounterUI1(_ counter: Int) {
        triangle1TextLabelNode.text = "x \(counter)"
    }
    func updateCounterUI2(_ counter: Int) {
        circle1TextLabelNode.text = "x \(counter)"
    }
}

