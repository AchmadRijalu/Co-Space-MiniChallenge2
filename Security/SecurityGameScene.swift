//
//  GameScene.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 21/06/23.
//

import SpriteKit
import GameplayKit

struct GuestQueueSecurity {
    var queue: Int
    var guest: SKNode
    var currentPosition: CGPoint
}

class SecurityGameScene: SKScene {
    let masterScene = SKScene(fileNamed: "SecurityGameScene")
    let securitybackground = SKSpriteNode(imageNamed : "security-background")
    let planetbackground = SKSpriteNode(imageNamed : "security-planet")
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
    var rectangle1textNode = SKNode()
    var rectangle1TextLabelNode = SKLabelNode()
    var triangle1textNode = SKNode()
    var triangle1TextLabelNode = SKLabelNode()
    var circle1textNode = SKNode()
    var circle1TextLabelNode = SKLabelNode()
    var counterrectangle = 10
    var countertriangle = 10
    var countercircle = 10
    var securitylabel = SKSpriteNode(imageNamed: "security-label")
    var locationList: [SKNode] = []
    var dissapearNode: SKNode = SKNode()
    var queueList: [GuestQueueSecurity] = []
    var guestTimer: Timer?
    var guestLeave: Bool = false
    let guestListTemplate = GuestDictionary().guestList
    var guestCounter = 5
    var healthCounter = 5
    var idCardClickable = true
    
    let timerBarWidth: CGFloat = 130.0
    let timerBarHeight: CGFloat = 15.0
    var timerBarNode: SKSpriteNode!
    var timerBarDuration: TimeInterval = 10
    let healthBarWidth: CGFloat = 130.0
    let healthBarHeight: CGFloat = 15.0 
    var healthBarNode: SKSpriteNode!
    
    override func sceneDidLoad() {
            
            if let security1backgroundNode = masterScene?.childNode(withName: "securitybackground") {
                securitybackground.name = "securitybackgroundNode"
                securitybackground.size = CGSize(width: UIScreen.main.bounds.width + 0.5 * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                securitybackground.position = security1backgroundNode.position
                securitybackground.zPosition = -3
                self.addChild(securitybackground)
            }
            
            if let planet1backgroundNode = masterScene?.childNode(withName: "planetbackground") {
                planetbackground.name = "planetbackgroundNode"
                planetbackground.size = CGSize(width:700, height: 350)
                planetbackground.position = planet1backgroundNode.position
                planetbackground.zPosition = -1
                self.addChild(planetbackground)
            }
            
            if let security1labelNode = masterScene?.childNode(withName: "securitylabel") {
                securitylabel.name = "planetbackgroundNode"
                securitylabel.size = CGSize(width:150, height: 50)
                securitylabel.position = security1labelNode.position
                securitylabel.zPosition = -1
                self.addChild(securitylabel)
            }
            
            if let rectangle1buttonNode = masterScene?.childNode(withName: "rectanglebutton") {
                rectangle.name = "rectangle1buttonNode"
                rectangle.size = CGSize(width: 65, height: 80)
                rectangle.position = rectangle1buttonNode.position
                rectangle.zPosition = 1
                self.addChild(rectangle)
            }
            
            if let rectangle1quantityNode = masterScene?.childNode(withName: "rectangleleft") {
                rectangleidentitycardquantity.name = "rectangle1quantityNode"
                rectangleidentitycardquantity.size = CGSize(width: 50, height: 30)
                rectangleidentitycardquantity.position = rectangle1quantityNode.position
                rectangleidentitycardquantity.zPosition = 1
                self.addChild(rectangleidentitycardquantity)
            }
            
            if let triangle1buttonNode = masterScene?.childNode(withName: "trianglebutton") {
                triangle.name = "triangle1buttonNode"
                triangle.size = CGSize(width: 65, height: 80)
                triangle.position = triangle1buttonNode.position
                triangle.zPosition = 1
                self.addChild(triangle)
            }
            
            if let triangle1quantityNode = masterScene?.childNode(withName: "triangleleft") {
                triangleidentitycardquantity.name = "triangle1quantityNode"
                triangleidentitycardquantity.size = CGSize(width: 50, height: 30)
                triangleidentitycardquantity.position = triangle1quantityNode.position
                triangleidentitycardquantity.zPosition = 1
                self.addChild(triangleidentitycardquantity)
            }
            
            if let circle1buttonNode = masterScene?.childNode(withName: "circlebutton") {
                circle.name = "circle1buttonNode"
                circle.size = CGSize(width: 65, height: 80)
                circle.position = circle1buttonNode.position
                circle.zPosition = 1
                self.addChild(circle)
            }
            
            if let circle1quantityNode = masterScene?.childNode(withName: "circleleft") {
                circleidentitycardquantity.name = "circle1quantityNode"
                circleidentitycardquantity.size = CGSize(width: 50, height: 30)
                circleidentitycardquantity.position = circle1quantityNode.position
                circleidentitycardquantity.zPosition = 1
                self.addChild(circleidentitycardquantity)
            }
            
            if let location1Node = masterScene?.childNode(withName: "location1") {
                pengunjung1.name = "pengunjung1"
                pengunjung1.size = CGSize(width: 100, height: 100)
                pengunjung1.position = location1Node.position
                pengunjung1.zPosition = 1
                let tags: NSMutableDictionary = [
                    "nama": "pengunjung1",
                    "kesabaran": 3,
                ]
                pengunjung1.userData = tags
                self.addChild(pengunjung1)
                
                locationList.append(location1Node)
                queueList.append(GuestQueueSecurity(queue: 1, guest: pengunjung1, currentPosition: locationList[0].position))
                
                timerRenewal(seconds: 3)
            }
            
            if let location2Node = masterScene?.childNode(withName: "location2") {
                pengunjung2.name = "pengunjung2"
                pengunjung2.size = CGSize(width: 100, height: 100)
                pengunjung2.position = location2Node.position
                pengunjung2.zPosition = 1
                let tags: NSMutableDictionary = [
                    "nama": "pengunjung2",
                    "kesabaran": 4,
                ]
                pengunjung2.userData = tags
                self.addChild(pengunjung2)
                
                locationList.append(location2Node)
                queueList.append(GuestQueueSecurity(queue: 2, guest: pengunjung2, currentPosition: locationList[1].position))
            }
            
            if let location3Node = masterScene?.childNode(withName: "location3") {
                pengunjung3.name = "pengunjung3"
                pengunjung3.size = CGSize(width: 100, height: 100)
                pengunjung3.position = location3Node.position
                pengunjung3.zPosition = 1
                let tags: NSMutableDictionary = [
                    "nama": "pengunjung3",
                    "kesabaran": 2,
                ]
                pengunjung3.userData = tags
                self.addChild(pengunjung3)
                
                locationList.append(location3Node)
                queueList.append(GuestQueueSecurity(queue: 3, guest: pengunjung3, currentPosition: locationList[2].position))
            }
            
            if let location4Node = masterScene?.childNode(withName: "location4") {
                pengunjung4.name = "pengunjung4"
                pengunjung4.size = CGSize(width: 100, height: 100)
                pengunjung4.position = location4Node.position
                pengunjung4.zPosition = 1
                let tags: NSMutableDictionary = [
                    "nama": "pengunjung4",
                    "kesabaran": 4,
                ]
                pengunjung4.userData = tags
                self.addChild(pengunjung4)
                
                locationList.append(location4Node)
                queueList.append(GuestQueueSecurity(queue: 4, guest: pengunjung4, currentPosition: locationList[3].position))
            }
            
            if let location5Node = masterScene?.childNode(withName: "location5") {
                pengunjung5.name = "pengunjung5"
                pengunjung5.size = CGSize(width: 100, height: 100)
                pengunjung5.position = location5Node.position
                pengunjung5.zPosition = 1
                let tags: NSMutableDictionary = [
                    "nama": "pengunjung5",
                    "kesabaran": 3,
                ]
                pengunjung5.userData = tags
                self.addChild(pengunjung5)
                
                locationList.append(location5Node)
                queueList.append(GuestQueueSecurity(queue: 5, guest: pengunjung5, currentPosition: locationList[4].position))
            }
            
            dissapearNode = masterScene?.childNode(withName: "disappearLocation") ?? SKNode()
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
            
            createTimerBar()
            createHealthBar()
            updateHealthBar()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if (idCardClickable){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "rectangle1buttonNode" {
                guestTimer?.invalidate()
                guestTimer = nil
                
                moveGuest()
                if counterrectangle > 0{
                    counterrectangle -= 1
                }
                updateCounterUI(counterrectangle)
            }
            
            else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circle1buttonNode" {
                guestTimer?.invalidate()
                guestTimer = nil
                
                moveGuest()
                if countercircle > 0{
                    countercircle -= 1
                }
                updateCounterUI2(countercircle)
            }
            
            else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangle1buttonNode" {
                guestTimer?.invalidate()
                guestTimer = nil
                
                moveGuest()
                if countertriangle > 0{
                    countertriangle -= 1
                }
                updateCounterUI1(countertriangle)
            }
        }
    }
    
    func moveGuest() {
        self.idCardClickable = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.idCardClickable = true
        }
        
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
                    let moveAction = SKAction.move(to: dissapearNode.position, duration: 1.0)
                    queueList[i].guest.run(moveAction)
                }
                else { // kalo misalnya kesabarannya udah habis
                    let moveAction = SKAction.moveBy(x: 0, y: -175, duration: 1.0)
                    queueList[i].guest.run(moveAction)
                    guestLeave = false
                    if healthCounter > 0 {
                        healthCounter -= 1
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.queueList[i].guest.removeFromParent()
                    self.queueList.removeFirst()
                    
                    let newGuest = self.generateNewGuest()
                    self.addChild(newGuest)
                    self.queueList.append(GuestQueueSecurity(queue: (self.queueList.count + 1), guest: newGuest, currentPosition: self.locationList[4].position))
                }
            }
        }
        
        let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "kesabaran") as? Int
        timerCount = 0
        self.guestTimer?.invalidate()
        self.guestTimer = nil
        updateTimerBar(progress: 100, full: 100)
        print("Timer Reset")
        timerRenewal(seconds: Int(firstQueueGuestTime!))
        updateHealthBar()
    }
    
    var healthCount: Int = 5
    func createHealthBar(){
        if let healthleftNode = masterScene?.childNode(withName: "healthleft"),
           let healthbarNode = masterScene?.childNode(withName: "healthbar"){
            // Create the health bar background
            let healthBarBackground = SKSpriteNode(imageNamed: "health-bar")
            healthBarBackground.size = CGSize(width: 170, height: 38)
            healthBarBackground.position = CGPoint(x: healthbarNode.position.x, y: healthbarNode.position.y)
            addChild(healthBarBackground)
            
            // Create the health bar node
            healthBarNode = SKSpriteNode(imageNamed: "life-bar-fill")
            healthBarNode.size = CGSize(width: healthBarWidth, height: healthBarHeight)
            healthBarNode.position = CGPoint(x: healthleftNode.position.x, y: healthleftNode.position.y)
            healthBarNode.anchorPoint = CGPoint(x: 0, y: 0.5)
            healthBarNode.zPosition = healthBarNode.zPosition + 1
            addChild(healthBarNode)
        }
    }
    
    func updateHealthBar() {
            let healthRatio = CGFloat(healthCounter) / 5.0
            let newWidth = healthBarWidth * healthRatio
            healthBarNode.size.width = newWidth
        }
    
    var timerCount: Double = 0
    private func timerRenewal(seconds: Int){
        self.guestTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.05), repeats: true) { timer in
            self.timerCount += 0.05
            
            self.updateTimerBar(progress: CGFloat(self.timerCount), full: CGFloat(seconds))
            if (self.timerCount >= Double(seconds)){
                self.guestLeave = true
                self.moveGuest()
            }
        }
    }
    
    func createTimerBar() {
        if let timeleftNode = masterScene?.childNode(withName: "timeleft"),
           let timebarNode = masterScene?.childNode(withName: "timebar"){
            // Create the timer bar background
            let timerBarBackground = SKSpriteNode(imageNamed: "timebar")
            timerBarBackground.size = CGSize(width: 170, height: 38)
            timerBarBackground.position = CGPoint(x: timebarNode.position.x, y: timebarNode.position.y)
            addChild(timerBarBackground)
            
            // Create the timer bar node
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
    
    func generateNewGuest() -> SKNode {
        guestCounter += 1
        
        let guestTemplate = guestListTemplate.randomElement()
        let newNode = SKSpriteNode(texture: SKTexture(imageNamed: (guestTemplate?.ImageName!)!))
        newNode.position = locationList[4].position
        newNode.name = "pengunjung\(guestCounter)"
        newNode.size = CGSize(width: 100, height: 100)
        let tags: NSMutableDictionary = [
            "nama": guestTemplate?.nama ?? "no-name",
            "kesabaran": guestTemplate?.kesabaranSecurity ?? 0,
        ]
        newNode.userData = tags
        
        return newNode
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

