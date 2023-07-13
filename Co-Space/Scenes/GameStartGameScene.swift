//
//  GameStartGameScene.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 13/07/23.
//

import Foundation
import SpriteKit
import AVFoundation
var hyperDriveInSoundEffect = AVAudioPlayer()
class GameStartGameScene : SKScene{
    
    
    var logoGameStartResultNode = SKSpriteNode()
    var spaceShipBackground = SKSpriteNode()
    var purpleBackground = SKSpriteNode()
    var dockGameStartResultNode = SKSpriteNode()
    
    
    
    
    func createAnimatedImagesArray(imageName: String, frameCount: Int) -> [SKTexture] {
        var animatedImages: [SKTexture] = []
        for index in 1..<frameCount{
            let textureName = "\(imageName)\(index)"
            let texture = SKTexture(imageNamed: textureName)
            animatedImages.append(texture)
        }
        
        return animatedImages
    }
    func playDriveInSoundEffect() {
        guard let url = Bundle.main.url(forResource: "transition-hyper-drive-in", withExtension: "wav") else { return }
        do {
            
            hyperDriveInSoundEffect = try AVAudioPlayer(contentsOf: url)
            hyperDriveInSoundEffect.numberOfLoops = 0
            hyperDriveInSoundEffect.enableRate = true
            hyperDriveInSoundEffect.rate = 2.0
            hyperDriveInSoundEffect.prepareToPlay()
            hyperDriveInSoundEffect.play()
            
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }

    
    
    override func didMove(to view: SKView) {
        self.spaceShipBackground = SKSpriteNode(imageNamed: "gamestart-background")
        self.spaceShipBackground.size = UIScreen.main.bounds.size
        self.spaceShipBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        self.spaceShipBackground.zPosition = 1
        self.spaceShipBackground.name = "gamestart-background"
        addChild(spaceShipBackground)
        self.purpleBackground = SKSpriteNode(imageNamed: "mainmenu-background-planet")
        self.purpleBackground.size = UIScreen.main.bounds.size
        self.purpleBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        self.purpleBackground.zPosition = -1
        self.purpleBackground.name = "mainmenu-background-planet"
        addChild(purpleBackground)
        
        self.purpleBackground = SKSpriteNode(imageNamed: "background-gamestart")
        self.purpleBackground.size = UIScreen.main.bounds.size
        self.purpleBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        self.purpleBackground.zPosition = -2
        self.purpleBackground.name = "background-gamestart"
        addChild(purpleBackground)
       
        // Create the dockChangedResultNode the animation asset and set its properties
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.logoGameStartResultNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.logoGameStartResultNode.name = "logo"
            self.logoGameStartResultNode.texture = SKTexture(imageNamed: "logo")
            self.logoGameStartResultNode.size = CGSize(width: 214.956, height: 214.202)
            self.logoGameStartResultNode.zPosition = 1
            self.addChild(self.logoGameStartResultNode)
            let fallAction = SKAction.move(to: CGPoint(x: 423.855, y: 240.825), duration: 0.3)
            let fadeInAction = SKAction.fadeIn(withDuration: 3.0)
            let sequence = SKAction.sequence([fallAction, fadeInAction])
            self.logoGameStartResultNode.run(sequence)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let spaceJumpTex = self.createAnimatedImagesArray(imageName: "SpaceJump", frameCount: 125)
            let spaceJumpAction = SKAction.animate(with: spaceJumpTex, timePerFrame: 0.03)
            var spriteNode = SKSpriteNode(texture: spaceJumpTex[0], size: self.size)
            spriteNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            spriteNode.zPosition = 0
            self.addChild(spriteNode)
            let sequence = SKAction.sequence([spaceJumpAction, SKAction.run { [weak spriteNode] in
                spriteNode?.removeFromParent()
            }])
            spriteNode.run(sequence)
            self.playDriveInSoundEffect()
            
        }
        
    }
}
