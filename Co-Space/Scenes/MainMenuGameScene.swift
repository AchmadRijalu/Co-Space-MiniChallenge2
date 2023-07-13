import Foundation
import SpriteKit
import SwiftUI
import AVFoundation


class MainMenuGameScene: SKScene, SKPhysicsContactDelegate {
    var game: MainGame?
    
    var planeSliderNode: SKSpriteNode!
    var isTapped:Bool = false
    var mainMenuLabelNode : SKSpriteNode!
    var mainMenuSoundNode: SKSpriteNode?
    let defaultPositionX:CGFloat = -98.107
    let minDragX: CGFloat = -98.107  // Batas minimum sumbu X
    let maxDragX: CGFloat = 105  // Batas maksimum sumbu X
    var audioPlayer: AVAudioPlayer?
    var backgroundMusic = SKAudioNode()
    var isBacksoundEnabled = true
    
//
    func playSoundMultipleTimes(count: Int) {
        guard let url = Bundle.main.url(forResource: "backsound", withExtension: "wav") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = count - 1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        } catch let error {
            print("error")
            print(error.localizedDescription)
        }
    }
    
    override func didMove(to view: SKView) {
        
        
        //Background Music
        playSoundMultipleTimes(count: 0)
        
        if let planeSliderNode = self.childNode(withName: "planeSliderNode"){
            self.planeSliderNode = planeSliderNode as? SKSpriteNode
            self.planeSliderNode.name = "planeSliderNode"
            self.planeSliderNode.position = planeSliderNode.position
            self.planeSliderNode.size = planeSliderNode.frame.size
            self.planeSliderNode.zPosition = planeSliderNode.zPosition
        }
        if let mainMenuLabelNode = self.childNode(withName: "mainMenuLabelNode"){
            self.mainMenuLabelNode = mainMenuLabelNode as! SKSpriteNode
            self.mainMenuLabelNode.name = "mainMenuLabelNode"
            self.mainMenuLabelNode.position = mainMenuLabelNode.position
            self.mainMenuLabelNode.size = mainMenuLabelNode.frame.size
            self.mainMenuLabelNode.zPosition = mainMenuLabelNode.zPosition
            
            let scaleUpAction = SKAction.scale(to: 0.6, duration: 1.0)
            let scaleDownAction = SKAction.scale(to: 0.5, duration: 1.0)
            let fadeOutAction = SKAction.fadeAlpha(to: 0.3, duration: 1.0)
            let fadeInAction = SKAction.fadeAlpha(to: 1.0, duration: 1.0)
            
            let pulseAction = SKAction.repeatForever(SKAction.sequence([scaleUpAction, scaleDownAction]))
            let fadeAction = SKAction.repeatForever(SKAction.sequence([fadeOutAction, fadeInAction]))
            
            self.mainMenuLabelNode.run(pulseAction)
            self.mainMenuLabelNode.run(fadeAction)
        }
        
        if let mainMenuSoundNode = self.childNode(withName: "soundButtonNode"){
            self.mainMenuSoundNode = mainMenuSoundNode as! SKSpriteNode
            self.mainMenuSoundNode?.name = "soundButtonNode"
            self.mainMenuSoundNode?.position = mainMenuSoundNode.position
            self.mainMenuSoundNode?.size = mainMenuSoundNode.frame.size
            
            print(self.mainMenuSoundNode)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes {
                if let spriteNode = node as? SKSpriteNode {
                    
                    if spriteNode.name == "soundButtonNode" {
                        if isBacksoundEnabled == true{
                            audioPlayer?.pause()
                            isBacksoundEnabled = false
                            self.mainMenuSoundNode?.texture = SKTexture(imageNamed: "mainmenu-button-sound-disabled")
                        }
                        else{
                            audioPlayer?.play()
                            isBacksoundEnabled = true
                            self.mainMenuSoundNode?.texture = SKTexture(imageNamed: "mainmenu-button-sound")
                        }
                    }
                    if spriteNode.name == "planeSliderNode" {
                        if let musicURL = Bundle.main.url(forResource: "swipe-rocket", withExtension: "wav") {
                            backgroundMusic = SKAudioNode(url: musicURL)
                            backgroundMusic.autoplayLooped = false
                            addChild(backgroundMusic)
                            backgroundMusic.run(SKAction.sequence([
                                SKAction.run {
                                    // this will start playing the pling once.
                                    self.backgroundMusic.run(SKAction.play())
                                }
                            ])
                            )
                        }
                    }
                    if  spriteNode.name == "planeSlider2Node"{
                        if let touch = touches.first {
                            let location = touch.location(in: self)
                            
                            if let touch = touches.first, spriteNode.frame.contains(touch.location(in: self)) {
                                let touchedNodes = self.nodes(at: location)
                                for node in touchedNodes.reversed() {
                                    if node.name == "planeSliderNode" {
                                        self.planeSliderNode = node as? SKSpriteNode
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = self.planeSliderNode else { return }
        
        let touchLocation = touch.location(in: self)
        let draggablePosition = min(max(touchLocation.x, minDragX), maxDragX)
        node.position.x = draggablePosition
        
        if node.position.x > -7 {
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
            mainMenuLabelNode.run(SKAction.group([fadeOutAction]))
            mainMenuLabelNode.isHidden = true
        } else {
            let fadeInAction = SKAction.fadeIn(withDuration: 0.1)
            mainMenuLabelNode.alpha = 0.0
            mainMenuLabelNode.run(SKAction.group([fadeInAction]))
            
        }
        
        if node.position.x > 98.6 {
            
//            let newScene = ResultGameScene(size: self.size) // Initialize new scene
//            newScene.game = game
//            let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5) // Set the transition effect
//            self.scene?.view?.presentScene(newScene, transition: transition) // Change the scene
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                self.audioPlayer?.stop()
//            }
                        game?.createRoom()
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = self.planeSliderNode else { return }
        let touchLocation = touch.location(in: self)
        let draggablePosition = min(max(touchLocation.x, minDragX), maxDragX)

        // User didn't drag the sprite, move it back to default position
        let moveBackAction = SKAction.move(to: CGPoint(x: defaultPositionX, y: node.position.y), duration: 0.1)
        node.run(moveBackAction)
        mainMenuLabelNode.isHidden = false
        
        
        
    }
    //MARK: - Animation Space Gif
    func createAnimatedImagesArray(imageName: String, frameCount: Int) -> [SKTexture] {
        var animatedImages: [SKTexture] = []
        for index in 1..<frameCount {
            let textureName = "\(imageName)\(index)"
            let texture = SKTexture(imageNamed: textureName)
            animatedImages.append(texture)
        }
        
        return animatedImages
    }
}
