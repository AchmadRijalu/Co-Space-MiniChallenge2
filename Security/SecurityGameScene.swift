//
//  GameScene.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 21/06/23.
//

import SpriteKit
import GameplayKit
import SwiftUI

struct GuestQueueSecurity {
    var queue: Int
    var guest: SKNode
}

class SecurityGameScene: SKScene {
    var game: MainGame!
    
    let securitybackground = SKSpriteNode(imageNamed : "security-background")
    let planetbackground = SKSpriteNode(imageNamed : "security-planet")
    let square = SKSpriteNode(imageNamed : "button-square")
    let squareidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let circle = SKSpriteNode(imageNamed : "button-circle")
    let circleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let triangle = SKSpriteNode(imageNamed : "button-triangle")
    let triangleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    var square1textNode = SKNode()
    var square1TextLabelNode = SKLabelNode()
    var triangle1textNode = SKNode()
    var triangle1TextLabelNode = SKLabelNode()
    var circle1textNode = SKNode()
    var circle1TextLabelNode = SKLabelNode()
    var securitylabel = SKSpriteNode(imageNamed: "security-label")
    var tappedSymbol = ""
    
    let newGuestPace = 5
    var locationList: [SKNode] = []
    var dissapearNode: SKNode = SKNode()
    var queueList: [GuestQueueSecurity] = []
    var guestTimer: Timer?
    var continuousTimer: Timer?
    var addNewGuestTimer: Int = 0
    var guestLeave: Bool = false
    let guestListTemplate = GuestSecurityDictionary().guestList
    var guestCounter = 0
    var idCardClickable = true
    
    let timerBarWidth: CGFloat = 130.0
    let timerBarHeight: CGFloat = 15.0
    var timerBarNode: SKSpriteNode!
    var timerBarDuration: TimeInterval = 10
    let healthBarWidth: CGFloat = 130.0
    let healthBarHeight: CGFloat = 15.0 
    var healthBarNode: SKSpriteNode!
    
    override func sceneDidLoad() {
        if let security1backgroundNode = scene?.childNode(withName: "securitybackground") {
            securitybackground.name = "securitybackgroundNode"
            securitybackground.size = CGSize(width: UIScreen.main.bounds.width + 0.5 * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            securitybackground.position = security1backgroundNode.position
            securitybackground.zPosition = -3
            self.addChild(securitybackground)
        }
        
        if let planet1backgroundNode = scene?.childNode(withName: "planetbackground") {
            planetbackground.name = "planetbackgroundNode"
            planetbackground.size = CGSize(width:700, height: 350)
            planetbackground.position = planet1backgroundNode.position
            planetbackground.zPosition = -1
            self.addChild(planetbackground)
        }
        
        if let security1labelNode = scene?.childNode(withName: "securitylabel") {
            securitylabel.name = "planetbackgroundNode"
            securitylabel.size = CGSize(width:150, height: 50)
            securitylabel.position = security1labelNode.position
            securitylabel.zPosition = -1
            self.addChild(securitylabel)
        }
        
        if let square1buttonNode = scene?.childNode(withName: "squarebutton") {
            square.name = "square1buttonNode"
            square.size = CGSize(width: 65, height: 80)
            square.position = square1buttonNode.position
            square.zPosition = 1
            self.addChild(square)
        }
        
        if let square1quantityNode = scene?.childNode(withName: "squareleft") {
            squareidentitycardquantity.name = "square1quantityNode"
            squareidentitycardquantity.size = CGSize(width: 50, height: 30)
            squareidentitycardquantity.position = square1quantityNode.position
            squareidentitycardquantity.zPosition = 1
            self.addChild(squareidentitycardquantity)
        }
        
        if let triangle1buttonNode = scene?.childNode(withName: "trianglebutton") {
            triangle.name = "triangle1buttonNode"
            triangle.size = CGSize(width: 65, height: 80)
            triangle.position = triangle1buttonNode.position
            triangle.zPosition = 1
            self.addChild(triangle)
        }
        
        if let triangle1quantityNode = scene?.childNode(withName: "triangleleft") {
            triangleidentitycardquantity.name = "triangle1quantityNode"
            triangleidentitycardquantity.size = CGSize(width: 50, height: 30)
            triangleidentitycardquantity.position = triangle1quantityNode.position
            triangleidentitycardquantity.zPosition = 1
            self.addChild(triangleidentitycardquantity)
        }
        
        if let circle1buttonNode = scene?.childNode(withName: "circlebutton") {
            circle.name = "circle1buttonNode"
            circle.size = CGSize(width: 65, height: 80)
            circle.position = circle1buttonNode.position
            circle.zPosition = 1
            self.addChild(circle)
        }
        
        if let circle1quantityNode = scene?.childNode(withName: "circleleft") {
            circleidentitycardquantity.name = "circle1quantityNode"
            circleidentitycardquantity.size = CGSize(width: 50, height: 30)
            circleidentitycardquantity.position = circle1quantityNode.position
            circleidentitycardquantity.zPosition = 1
            self.addChild(circleidentitycardquantity)
        }
        
        square1textNode = self.childNode(withName: "squaretext")!
        let squaretext = SKLabelNode(fontNamed: "Arial")
        squaretext.fontColor = .black
        squaretext.fontSize = 12
        squaretext.position = square1textNode.position
        squaretext.zPosition = 2
        square1TextLabelNode = squaretext
        self.addChild(squaretext)
        
        triangle1textNode = self.childNode(withName: "triangletext")!
        let triangletext = SKLabelNode(fontNamed: "Arial")
        triangletext.fontColor = .black
        triangletext.fontSize = 12
        triangletext.position = triangle1textNode.position
        triangletext.zPosition = 2
        triangle1TextLabelNode = triangletext
        self.addChild(triangletext)
        
        circle1textNode = self.childNode(withName: "circletext")!
        let circletext = SKLabelNode(fontNamed: "Arial")
        circletext.fontColor = .black
        circletext.fontSize = 12
        circletext.position = circle1textNode.position
        circletext.zPosition = 2
        circle1TextLabelNode = circletext
        self.addChild(circletext)
        
        for i in 1...5 {
            if let locationNode = scene?.childNode(withName: "location\(i)") {
                locationList.append(locationNode)
            }
        }
        
        self.dissapearNode = scene?.childNode(withName: "disappearLocation") ?? SKNode()
        createHealthBar()
        createTimerBar()
              
        updateCounterUI(symbol: "triangle")
        updateCounterUI(symbol: "circle")
        updateCounterUI(symbol: "square")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.continuousTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.addNewGuestTimer += 1
                self.checkQueue()
                if (self.addNewGuestTimer >= self.newGuestPace){
                    if (self.queueList.count < 5){
                        let newGuestNode = self.generateNewGuest()
                        let queueCount = self.queueList.count
                        self.addChild(newGuestNode)
                        newGuestNode.run(SKAction.move(to: self.locationList[queueCount].position, duration: 0.5))
                        if ((queueCount + 1) == 1){
                            let firstQueueGuestTime = newGuestNode.userData?.value(forKey: "patience") as? Int
                            self.timerRenewal(seconds: firstQueueGuestTime ?? 5)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.queueList.append(GuestQueueSecurity(queue: (queueCount + 1), guest: newGuestNode))
                        }
                        self.addNewGuestTimer = 0
                    }
                    else {
                        print("Full Queue")
                    }
                }
                self.updateHealthBar(newHealth: self.game.health)
                print("New Health \(self.game.health)")
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
//        print("Health dari Scene \(game.health)")
        print("Health dari scene \(self.game.health)")
        
        if (idCardClickable && self.queueList.count > 0){
            if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "square1buttonNode" {
                usingIdentityCard(symbol: "square")
            }
            else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "circle1buttonNode" {
                usingIdentityCard(symbol: "circle")
            }
            else if let node = self.atPoint(touchLocation) as? SKSpriteNode, node.name == "triangle1buttonNode" {
                usingIdentityCard(symbol: "triangle")
            }
        }
    }
    
    func usingIdentityCard (symbol: String) {
        self.tappedSymbol = symbol
        let result = game.useIdentityCard(symbol: symbol)
        if (result == "success" || result == "empty"){
            guestTimer?.invalidate()
            guestTimer = nil
            updateCounterUI(symbol: symbol)
            moveGuest()
            if (result == "empty"){
                // Disable button
                
            }
        }
        else {
            // Feedback kalo abis
            
        }
    }
    
    func usingIdentityCard2(symbol: String){
        self.tappedSymbol = symbol
//        game?.availableIdCard[symbol]! -= 1
//        game?.useIdentityCard(symbol: symbol)
        guestTimer?.invalidate()
        guestTimer = nil
        updateCounterUI(symbol: symbol)
        moveGuest()
    }
    
    func checkQueue(){
        if (self.game == nil){
            print("nil disini")
        }
        if (self.queueList.count > 0){
            for i in 0...(queueList.count - 1) {
                queueList[i].queue = i + 1
                let moveAction = SKAction.move(to: locationList[i].position, duration: 0.5)
                queueList[i].guest.run(moveAction)
                if (i == 0 && self.guestTimer == nil) {
                    let firstQueueGuestTime = queueList[i].guest.userData?.value(forKey: "patience") as? Int
                    timerRenewal(seconds: firstQueueGuestTime ?? 5)
                }
            }
        }
    }
    
    func moveGuest() {
        self.idCardClickable = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.idCardClickable = true
        }
        
        var removeFirst = false
        for i in 0...(queueList.count - 1) {
            if (queueList[i].queue > 1){
                let nextQueue = queueList[i].queue - 1
                
                // Animation jalannya
                let moveAction = SKAction.move(to: locationList[nextQueue - 1].position, duration: 1.0)
                queueList[i].guest.run(moveAction)
                
                // Perbarui queuenya yang sekarang
                queueList[i].queue = nextQueue
            }
            else {
                let artificialGuestNode = SKSpriteNode()
                artificialGuestNode.size = CGSize(width: 100, height: 100)
                artificialGuestNode.position = queueList[i].guest.position
                let artificialGuestNodeTexture = queueList[0].guest.userData?.value(forKey: "image") as? String
                artificialGuestNode.texture = SKTexture(imageNamed: artificialGuestNodeTexture ?? "")
                artificialGuestNode.zPosition = 4
                scene?.addChild(artificialGuestNode)
                
                removeFirst = true
                self.queueList[i].guest.removeFromParent()
                
                // Kalo guestnya udah dikasih tanda
                if (!guestLeave){
                    // Udah masuk ke guide
                    let moveAction = SKAction.move(to: dissapearNode.position, duration: 1.0)
                    artificialGuestNode.run(moveAction)
                    artificialGuestNode.run(SKAction.scale(to: 0.5, duration: 1.0))
                    
                    game?.sendGuestToGuide(symbol: tappedSymbol, imageName: artificialGuestNodeTexture ?? "guest-1")
                }
                else { // kalo misalnya patiencenya udah habis
                    let moveAction = SKAction.moveBy(x: 0, y: -175, duration: 1.0)
                    artificialGuestNode.run(moveAction)
                    guestLeave = false
//                    self.game.health -= 1
                    self.game.updateHealth(add: false, amount: 1)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    artificialGuestNode.removeFromParent()
                }
            }
        }
        
        if (removeFirst) {
            self.queueList.removeFirst()
        }
        
        timerCount = 0
        self.guestTimer?.invalidate()
        self.guestTimer = nil
        updateTimerBar(progress: 0, full: 100)
        
        if (self.queueList.count > 0){
            let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "patience") as? Int
            timerRenewal(seconds: Int(firstQueueGuestTime!))
        }
    }
    
    var healthCount: Int = 5
    func createHealthBar(){
        if let healthleftNode = scene?.childNode(withName: "healthleft"),
           let healthbarNode = scene?.childNode(withName: "healthbar"){
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
    
    func updateHealthBar(newHealth: Int) {
        let healthRatio = CGFloat(newHealth) / 5.0
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
        if let timeleftNode = scene?.childNode(withName: "timeleft"),
           let timebarNode = scene?.childNode(withName: "timebar"){
            // Create the timer bar background
            let timerBarBackground = SKSpriteNode(imageNamed: "timebar")
            timerBarBackground.size = CGSize(width: 170, height: 38)
            timerBarBackground.position = CGPoint(x: timebarNode.position.x, y: timebarNode.position.y)
            addChild(timerBarBackground)
            
            // Create the timer bar node
            self.timerBarNode = SKSpriteNode(imageNamed: "timebar-fill")
            self.timerBarNode.size = CGSize(width: timerBarWidth, height: timerBarHeight)
            self.timerBarNode.position = CGPoint(x: timeleftNode.position.x, y: timeleftNode.position.y)
            self.timerBarNode.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.timerBarNode.zPosition = self.timerBarNode.zPosition + 1
            addChild(self.timerBarNode)
        }
    }

    func updateTimerBar(progress: CGFloat, full: CGFloat) {
        let newWidth = (1.0 - (Double(progress) / Double(full))) * 130
        timerBarNode.size.width = newWidth
    }
    
    func generateNewGuest() -> SKNode {
        guestCounter += 1
        
        let guestTemplate = guestListTemplate.randomElement()
        let newNode = SKSpriteNode(texture: SKTexture(imageNamed: (guestTemplate?.imageName!)!))
        newNode.position = locationList[4].position
        newNode.name = "guest-\(guestCounter)"
        newNode.size = CGSize(width: 100, height: 100)
        newNode.zPosition = 10
        let tags: NSMutableDictionary = [
            "nama": guestTemplate?.name ?? "no-name",
            "patience": Int.random(in: (self.game.patienceRangeSecurity["start"]!)...(self.game.patienceRangeSecurity["end"]!)),
            "image": guestTemplate?.imageName
        ]
        newNode.userData = tags
        
        return newNode
    }
    
    func updateCounterUI(symbol: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let newCount = "x \((self.game.availableIdCard[symbol])!)"
            if (symbol == "square"){
                self.square1TextLabelNode.text = newCount
            }
            else if (symbol == "triangle") {
                self.triangle1TextLabelNode.text = newCount
            }
            else if (symbol == "circle") {
                self.circle1TextLabelNode.text = newCount
            }
        }
    }
}

