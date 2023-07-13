//
//  ResultGameScene.swift
//  Co-Space
//
//  Created by Nathalia Minoque Kusuma Salma Rasyid Jr. on 04/07/23.
//

import Foundation
import SpriteKit
import AVFoundation
var cospaceGameOverAnnouncerSoundEffect = AVAudioPlayer()

class ResultGameScene : SKScene,  SKPhysicsContactDelegate, ObservableObject{
    
    var game : MainGame!
    
    var moonResultNode =  SKSpriteNode()
    var logoResultNode = SKSpriteNode()
    var backgroundNode = SKSpriteNode()
    var dockResultNode = SKSpriteNode()
    var dockChangedResultNode = SKSpriteNode()
    var backgroundFinal = SKSpriteNode()
    var gameOverResultNode = SKSpriteNode()
    var playAgainResultNode = SKSpriteNode()
    var exitResultNode = SKSpriteNode()
    var hyperDriveOutSoundEffect = AVAudioPlayer()
    var gameOverSoundEffect = SKAudioNode()
    var scoretext = SKLabelNode()
    var score = SKLabelNode()
    
    func createAnimatedImagesArrayReverse(imageName: String, frameCount: Int) -> [SKTexture] {
        var animatedImages: [SKTexture] = []
        for index in (1..<frameCount).reversed() {
            let textureName = "\(imageName)\(index)"
            let texture = SKTexture(imageNamed: textureName)
            animatedImages.append(texture)
        }
        
        return animatedImages
    }
    
    func playAnnouncerSoundEffect(nameSound:String) {
        guard let url = Bundle.main.url(forResource: nameSound, withExtension: "wav") else { return }
        do {
            
            cospaceGameOverAnnouncerSoundEffect = try AVAudioPlayer(contentsOf: url)
            cospaceGameOverAnnouncerSoundEffect.numberOfLoops = 0
            cospaceGameOverAnnouncerSoundEffect.prepareToPlay()
            cospaceGameOverAnnouncerSoundEffect.play()
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    
    func playDriveOutSoundEffect() {
        guard let url = Bundle.main.url(forResource: "transition-hyper-drive-out", withExtension: "wav") else { return }
        do {
            
            hyperDriveOutSoundEffect = try AVAudioPlayer(contentsOf: url)
            hyperDriveOutSoundEffect.numberOfLoops = 0
            hyperDriveOutSoundEffect.enableRate = true
            hyperDriveOutSoundEffect.rate = 2.0
            hyperDriveOutSoundEffect.prepareToPlay()
            DispatchQueue.main.asyncAfter(deadline: .now() +  0.1){
                self.hyperDriveOutSoundEffect.play()
            }
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    func playGameOverSoundEffect() {
        guard let url = Bundle.main.url(forResource: "game-over", withExtension: "wav") else { return }
        do {
            
            hyperDriveOutSoundEffect = try AVAudioPlayer(contentsOf: url)
            hyperDriveOutSoundEffect.numberOfLoops = 0
            hyperDriveOutSoundEffect.prepareToPlay()
            self.hyperDriveOutSoundEffect.play()
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func easeOutElastic(_ t: CGFloat) -> CGFloat {
        let p: CGFloat = 0.4
        let s: CGFloat = 0.3
        return pow(2, -10 * t) * sin((t - s) * (2 * .pi) / p) + 1
    }
    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = .clear
        //Background sprite
        
        backgroundNode.size = self.size
        backgroundNode.color = SKColor.black.withAlphaComponent(0.9)
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.zPosition = 1
        addChild(backgroundNode)
        let fadeInActionBackground = SKAction.fadeIn(withDuration: 8.0)
        backgroundNode.run(fadeInActionBackground)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            //Moon sprite
            self.moonResultNode.name = "moonResultNode"
            self.moonResultNode.position = CGPoint(x: 423.855, y: self.size.height + self.moonResultNode.size.height / 2)
            self.moonResultNode.texture = SKTexture(imageNamed: "result-moon")
            self.moonResultNode.size = CGSize(width: 326.067, height: 325.313)
            self.moonResultNode.zPosition = 4
            self.addChild(self.moonResultNode)
            
            let fallAction = SKAction.move(to: CGPoint(x: 423.855, y: 233.825), duration: 0.3)
            let fadeInAction = SKAction.fadeIn(withDuration: 3.0)
            let sequence = SKAction.sequence([fallAction, fadeInAction])
            self.moonResultNode.run(sequence)
            
            
            
            //Logo sprite
            self.logoResultNode.name = "logoResultNode"
            self.logoResultNode.texture = SKTexture(imageNamed: "result-logo-game-over")
            self.logoResultNode.size = CGSize(width: 254.459, height: 172.181)
            self.moonResultNode.addChild(self.logoResultNode)
            self.logoResultNode.position = CGPoint(x: 0, y: 0)
            
            let logoInitialScale: CGFloat = 0.0
            let logoFinalScale: CGFloat = 1.0
            let logoAnimationDuration: TimeInterval = 0.5
            let logoAnimationDelay: TimeInterval = 0.5
            
            let scaleDownAction = SKAction.scale(to: logoInitialScale, duration: 0.0)
            let waitAction = SKAction.wait(forDuration: logoAnimationDelay)
            let scaleUpAction = SKAction.scale(to: logoFinalScale, duration: logoAnimationDuration)
            
            // Apply the timing mode to the scaleUpAction
            scaleUpAction.timingMode = .easeOut
            
            let logoSequence = SKAction.sequence([scaleDownAction, waitAction, scaleUpAction])
            self.logoResultNode.run(logoSequence)
            self.playGameOverSoundEffect()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                self.playAnnouncerSoundEffect(nameSound: "cospace-announcer")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) {
            //resize it to small
            let newSize = CGSize(width: 215.056, height: 214.202)
            let resizeAction = SKAction.scale(to: newSize, duration: 0.5)
            resizeAction.timingMode = .easeOut
            
            self.moonResultNode.run(resizeAction)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                // Set initial scale for the dockResultNode
                let initialScale: CGFloat = 1.0
                
                // Set final scale for the dockResultNode (full size of the screen)
                let finalScale: CGFloat = 0.0
                
                // Set animation duration
                let animationDuration: TimeInterval = 1.0
                // Set spring-like animation properties
                let damping: CGFloat = 0.4
                let initialVelocity: CGFloat = 0.0
                // Create the dockChangedResultNode the animation asset and set its properties
                self.dockChangedResultNode = SKSpriteNode(imageNamed: "result-background-dock")
                self.dockChangedResultNode.name = "result-background-dock"
                self.dockChangedResultNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                self.dockChangedResultNode.size = self.size
                self.dockChangedResultNode.zPosition = 3
                self.dockChangedResultNode.setScale(initialScale)
                
                // Add the dockResultNode to the scene
                self.addChild(self.dockChangedResultNode)
                
                // Set up the spring-like animation using scale and spring actions
                let scaleAction = SKAction.scale(to: finalScale, duration: animationDuration)
                let springAction = SKAction.customAction(withDuration: animationDuration) { (node, time) in
                    let normalizedTime = time / CGFloat(animationDuration)
                    let dampingFactor = pow(2.0, -10.0 * normalizedTime) * sin((normalizedTime - damping / 4.0) * (CGFloat.pi * 2.0) / damping)
                    let scale = initialScale + dampingFactor * (finalScale - initialScale)
                    self.dockChangedResultNode.setScale(scale)
                }
                // Apply spring-like animation properties
                springAction.timingMode = .easeOut
                // Run the spring-like animation on the dockResultNode
                self.dockChangedResultNode.run(SKAction.group([scaleAction, springAction]))
                
                let labelNode = SKLabelNode(text: "Score")
                labelNode.fontName = "Arial"
                labelNode.fontSize = 24
                labelNode.fontColor = .white
                labelNode.position = CGPoint(x: (self.size.width - (0.1 * self.size.width)) / 2, y: (self.size.height - (0.55 * self.size.height)) / 2)
                labelNode.zPosition = 5
                self.addChild(labelNode)
                
                let score: Int = self.game.score
                let scoreNode = SKLabelNode(text: String(score))
                scoreNode.fontName = "Arial"
                scoreNode.fontSize = 24
                scoreNode.fontColor = .white
                scoreNode.position = CGPoint(x: (self.size.width + (0.1 * self.size.width)) / 2, y: (self.size.height - (0.55 * self.size.height)) / 2)
                scoreNode.zPosition = 5
                self.addChild(scoreNode)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                // Create the dockResultNode constant and set its properties
                self.dockResultNode = SKSpriteNode(imageNamed: "result-interior")
                self.dockResultNode.name = "result-interior"
                self.dockResultNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                self.dockResultNode.size = self.size
                self.dockResultNode.zPosition = 1
                self.addChild(self.dockResultNode)
                
                //space gif play animation
                let spaceJumpTex = self.createAnimatedImagesArrayReverse(imageName: "SpaceJump", frameCount: 125)
                
                
                let spaceJumpAction = SKAction.animate(with: spaceJumpTex, timePerFrame: 0.03)
                
                var spriteNode = SKSpriteNode(texture: spaceJumpTex[0], size: self.size)
                spriteNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                spriteNode.zPosition = -1
                self.backgroundNode.removeFromParent()
                self.addChild(spriteNode)
                let sequence = SKAction.sequence([spaceJumpAction, SKAction.run { [weak spriteNode] in
                    spriteNode?.removeFromParent()
                }])
                spriteNode.run(sequence)
                
                //play hyper drive out animation
                self.playDriveOutSoundEffect()
                
                
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                self.moonResultNode.removeFromParent()
                let initialPositionGameOver = CGPoint(x: self.size.width / 2, y: -self.gameOverResultNode.size.height / 2)
                let finalPositionGameOver = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 100)
                self.gameOverResultNode = SKSpriteNode(imageNamed: "result-text-game-over")
                self.gameOverResultNode.name = "result-text-game-over"
                self.gameOverResultNode.size = CGSize(width: 193.5, height: 27)
                self.gameOverResultNode.position = initialPositionGameOver
                self.gameOverResultNode.zPosition = 3
                
                let initialPositionPlayAgain = CGPoint(x: self.size.width / 2, y: -self.playAgainResultNode.size.height / 2)
                let finalPositionPlayAgain = CGPoint(x: self.size.width / 2 - 120, y: self.size.height / 2)
                self.playAgainResultNode = SKSpriteNode(imageNamed: "result-button-play-again")
                self.playAgainResultNode.name = "result-button-play-again"
                self.playAgainResultNode.size = CGSize(width: 150, height: 50)
                self.playAgainResultNode.position = finalPositionPlayAgain
                self.playAgainResultNode.zPosition = 3
                
               
                
                let initialPositionExit = CGPoint(x: self.size.width / 2, y: -self.exitResultNode.size.height / 2)
                let finalPositionExit = CGPoint(x: self.size.width / 2 + 120, y: self.size.height / 2)
                self.exitResultNode = SKSpriteNode(imageNamed: "result-button-exit")
                self.exitResultNode.name = "result-button-exit"
                self.exitResultNode.size = CGSize(width: 150, height: 50)
                self.exitResultNode.position = finalPositionExit
                self.exitResultNode.zPosition = 3
                
                
                let animationDuration: TimeInterval = 0.7
                
                let moveActionGameOver = SKAction.customAction(withDuration: animationDuration) { node, elapsedTime in
                    let t = elapsedTime / animationDuration
                    let y = self.easeOutElastic(t) * (finalPositionGameOver.y - initialPositionGameOver.y) + initialPositionGameOver.y
                    node.position = CGPoint(x: finalPositionGameOver.x, y: y)
                }
                
                let moveActionPlayAgain = SKAction.customAction(withDuration: animationDuration) { node, elapsedTime in
                    let t = elapsedTime / animationDuration
                    let y = self.easeOutElastic(t) * (finalPositionPlayAgain.y - initialPositionPlayAgain.y) + initialPositionPlayAgain.y
                    node.position = CGPoint(x: finalPositionPlayAgain.x, y: y)
                }
                
                let moveActionExit = SKAction.customAction(withDuration: animationDuration) { node, elapsedTime in
                    let t = elapsedTime / animationDuration
                    let y = self.easeOutElastic(t) * (finalPositionExit.y - initialPositionExit.y) + initialPositionExit.y
                    node.position = CGPoint(x: finalPositionExit.x, y: y)
                }
                
                
                
                let player = IngameViewModel.shared
                player.gameStartBacksound.stop()
                
                self.addChild(self.gameOverResultNode)
                self.addChild(self.exitResultNode)
                self.addChild(self.playAgainResultNode)
                self.gameOverResultNode.run(moveActionGameOver)
                self.playAgainResultNode.run(moveActionPlayAgain)
                self.exitResultNode.run(moveActionExit)
                
                self.backgroundFinal = SKSpriteNode(imageNamed: "result-final-background")
                self.backgroundFinal.name = "result-final-background"
                self.backgroundFinal.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                self.backgroundFinal.size = self.size
                self.backgroundFinal.zPosition = -1
                self.addChild(self.backgroundFinal)
                
                
                
            }
            
        }
    }
    private func setupLabelNode(_ position: CGPoint, _ text: String) -> SKLabelNode {
        let labelNode = SKLabelNode(fontNamed: "SpaceGrotesk-Bold")
        labelNode.text = text
        labelNode.fontColor = .black
        labelNode.fontSize = 12
        labelNode.position = position
        labelNode.zPosition = 2
        return labelNode
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes {
                if let spriteNode = node as? SKSpriteNode {
                    if spriteNode.name == "result-button-play-again" {
                        print("Touched result-button-play-again")
                    } else if spriteNode.name == "result-button-exit" {
                        print("Touched result-button-exit")
                        // Add your scene transition code here
                        let newScene = SKScene(fileNamed: "MainMenuGameScene.sks") as! MainMenuGameScene
                        newScene.size = self.size
                        newScene.game = game
                        newScene.scaleMode = .fill
                        newScene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
                        
                        let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5) // Set the transition effect
                        //                        view?.presentScene(newScene, transition: transition)
                        self.scene?.view?.presentScene(newScene, transition: transition) // Change the scene
                    }
                }
            }
        }
    }
    
    
    
    
}

