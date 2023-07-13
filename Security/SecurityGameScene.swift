//
//  GameScene.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 21/06/23.
//

import SpriteKit
import GameplayKit
import SwiftUI
import AVFoundation

struct GuestQueueSecurity {
    var queue: Int
    var guest: SKNode
}

class SecurityGameScene: SKScene {
    var game: MainGame!
    
    let securitybackground = SKSpriteNode(imageNamed : "security-background")
    let planetbackground = SKSpriteNode(imageNamed : "security-moon-editable")
    let square = SKSpriteNode(imageNamed : "button-square")
    let squareidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let circle = SKSpriteNode(imageNamed : "button-circle")
    let circleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let triangle = SKSpriteNode(imageNamed : "button-triangle")
    let triangleidentitycardquantity = SKSpriteNode(imageNamed: "identity-card-qty")
    let backgroundstage = SKSpriteNode(imageNamed: "security-stage-1")
    let texturestage = [ "security-stage-1",  "security-stage-2",  "security-stage-3",  "security-stage-4"]
    var currentTextureIndex = 0
    var square1textNode = SKNode()
    var square1TextLabelNode = SKLabelNode()
    var triangle1textNode = SKNode()
    var triangle1TextLabelNode = SKLabelNode()
    var circle1textNode = SKNode()
    var circle1TextLabelNode = SKLabelNode()
    var securitylabel = SKSpriteNode(imageNamed: "security-label")
    var tappedSymbol = ""
    var counteralien = 1
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
    
    
    //MARK: - Declaring sound effect avaudioplayer
    var SoundEffect = AVAudioPlayer()
    var lowHealthSoundEffect = AVAudioPlayer()
//    var lowTimerSoundEffect = SKAudioNode()
    var lowTimerSoundEffect = AVAudioPlayer()
    
    func playSoundEffect(sound:String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }
        do {
            SoundEffect = try AVAudioPlayer(contentsOf: url)
            SoundEffect.numberOfLoops = 0
            SoundEffect.prepareToPlay()
            SoundEffect.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func playLowHealthStatusSoundEffect() {
        guard let url = Bundle.main.url(forResource: "low-health", withExtension: "wav") else { return }
        do {
            lowHealthSoundEffect = try AVAudioPlayer(contentsOf: url)
            lowHealthSoundEffect.numberOfLoops = -1
            lowHealthSoundEffect.prepareToPlay()
            lowHealthSoundEffect.volume = 0.5
            lowHealthSoundEffect.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stopLowHealthStatusSoundEffect() {
        guard let url = Bundle.main.url(forResource: "low-health", withExtension: "wav") else { return }
        do {
            lowHealthSoundEffect = try AVAudioPlayer(contentsOf: url)
            lowHealthSoundEffect.stop()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
        func playLowTimerStatusSoundEffect() {
            guard let url = Bundle.main.url(forResource: "low-timer", withExtension: "wav") else { return }
            do {
                lowTimerSoundEffect = try AVAudioPlayer(contentsOf: url)
                lowTimerSoundEffect.numberOfLoops = 0
                lowTimerSoundEffect.prepareToPlay()
                lowTimerSoundEffect.play()
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    
    
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
            planetbackground.size = CGSize(width:800, height: 280)
            planetbackground.position = planet1backgroundNode.position
            planetbackground.zPosition = -1
            self.addChild(planetbackground)
        }
        if let background1stageNode = scene?.childNode(withName: "backgroundstage") {
            backgroundstage.name = "backgroundstageNode"
            backgroundstage.size = CGSize(width:280, height: 170)
            backgroundstage.position = background1stageNode.position
            backgroundstage.zPosition = -1
            self.addChild(backgroundstage)
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
        
        if let square1quantityNode = scene?.childNode(withName: "rectangleleft") {
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
    }
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint (x: 1000, y: 0)
            particles.advanceSimulationTime(60)
            particles.zPosition = -2
            addChild(particles)
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.counteralien = (self.counteralien % 4) + 1
                   }
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
                self.updateCounterUI()
                print("New Health \(self.game.health)")
                if self.game.health <= 2 && self.game.health > 0{
                    self.playLowHealthStatusSoundEffect()
                }
                if self.game.health <= 0 {
                     self.lowHealthSoundEffect.stop()
                    self.continuousTimer?.invalidate()
                    self.continuousTimer = nil
                }
            }
            self.continuousTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.counteralien = (self.counteralien % 4) + 1
                self.updateCounterAlienForQueueList()
                self.addNewGuestTimer += 1
                
            }
        }
        
        // CHANGE GAME PACE
//        DispatchQueue.main.asyncAfter(deadline: .now() + 120.0) {
//            self.game.patienceRangeSecurity = ["start": 7, "end": 9]
//        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            // Update the texture
           self.currentTextureIndex = (self.currentTextureIndex + 1) % self.texturestage.count
            let textureName = self.texturestage[self.currentTextureIndex]
            self.backgroundstage.texture = SKTexture(imageNamed: textureName)
        }
    }
    
    func handleClick(for node: SKSpriteNode, with textures: (pressed: String, unpressed: String), and symbol: String) {
        let clicked = SKAction.setTexture(SKTexture(imageNamed: textures.pressed))
        let unclicked = SKAction.setTexture(SKTexture(imageNamed: textures.unpressed))
        let delay = SKAction.wait(forDuration: 0.5)
        let sequence = SKAction.sequence([clicked, delay, unclicked])
        
        node.run(sequence)
        playSoundEffect(sound: "teleport-to-guide")
        usingIdentityCard(symbol: symbol)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        //        print("Health dari Scene \(game.health)")
        print("Health dari scene \(self.game.health)")
        
        if idCardClickable && queueList.count > 0 {
            if let node = atPoint(touchLocation) as? SKSpriteNode {
                switch node.name {
                case "square1buttonNode":
                    handleClick(for: node, with: ("security-button-rectangle-pressed", "button-rectangle"), and: "square")
                case "circle1buttonNode":
                    handleClick(for: node, with: ("security-button-circle-pressed", "button-circle"), and: "circle")
                case "triangle1buttonNode":
                    handleClick(for: node, with: ("security-button-triangle-pressed", "button-triangle"), and: "triangle")
                default:
                    break
                }
            }
        }
    }
    
    func usingIdentityCard (symbol: String) {
        self.tappedSymbol = symbol
        let result = game.useIdentityCard(symbol: symbol)
        if (result == "success" || result == "empty"){
            guestTimer?.invalidate()
            guestTimer = nil
            updateCounterUI()
            moveGuest()
            if (result == "empty"){
                // Disable button
            }
        }
        else {
            // Feedback kalo abis
            
        }
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
                    if healthCount  <= 0 {
                        lowHealthSoundEffect.stop()
                        lowTimerSoundEffect.stop()
                        SoundEffect.stop()
                    }
                    else{
                        playSoundEffect(sound: "angry-alien")
                    }
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
        
        if healthBarNode.size.width <= 52{
        }
        
    }
    
    var timerCount: Double = 0
    var isLowerTimer:Bool = false
    
    private func timerRenewal(seconds: Int){
        self.isLowerTimer = false
        self.guestTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.05), repeats: true) { timer in
            self.timerCount += 0.05
            if self.timerCount > (Double(seconds) - 2.5){
                if self.isLowerTimer == false{
                    self.playLowTimerStatusSoundEffect()
                    self.isLowerTimer = true
                }
            }
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
        //        print(timerBarNode.size.width)
        
        
    }
    
    func generateNewGuest() -> SKNode {
        guestCounter += 1
        let guestTemplate = guestListTemplate.randomElement()
        let imageName = guestTemplate?.imageName ?? "default-image"
        let newNode = SKSpriteNode(texture: SKTexture(imageNamed: "\(imageName)-\(counteralien)"))
        newNode.position = locationList[4].position
        newNode.name = "guest-\(guestCounter)"
        newNode.size = CGSize(width: 100, height: 100)
        newNode.zPosition = 10

        var tags: [String: Any] = [
            "nama": guestTemplate?.name ?? "no-name",
            "patience": Int.random(in: (self.game.patienceRangeSecurity["start"]!)...(self.game.patienceRangeSecurity["end"]!)),
            "image2": newNode,
            "image": guestTemplate?.imageName
        ]

        // Add or update the counteralien value in the tags dictionary
        tags["counteralien"] = counteralien

        newNode.userData = NSMutableDictionary(dictionary: tags)

        return newNode
    }
    
    func updateCounterAlienForQueueList() {
        for guestQueueSecurity in queueList {
            if var userData = guestQueueSecurity.guest.userData as? [String: Any] {
                if let guestNode = userData["image2"] as? SKSpriteNode {
                    if let guestTemplate = guestListTemplate.first(where: { $0.name == userData["nama"] as? String }) {
                        let imageName = guestTemplate.imageName ?? "default-image"
                        guestNode.texture = SKTexture(imageNamed: "\(imageName)-\(counteralien)")
                    }
                }
            }
        }
    }
    func updateCounterUI() {
        self.square1TextLabelNode.text = "x \(self.game.idCardSquare)"
        self.triangle1TextLabelNode.text = "x \(self.game.idCardTriangle)"
        self.circle1TextLabelNode.text = "x \(self.game.idCardCircle)"
    }
}

