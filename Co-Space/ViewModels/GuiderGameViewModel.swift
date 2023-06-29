//
//  GuiderGameViewModel.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 28/06/23.
//

import Foundation
import SpriteKit

class GuiderGameViewModel : ObservableObject{
    
    
    @Published var selectGuest:Bool = false
    
    //for spawn state
    @Published var firstGuestSpawned = false
    @Published var secondGuestSpawned = false
    @Published var thirdGuestSpawned = false
    
    //for the time
    @Published var timerState:Bool = false
    
    //for detecting ever be index 1 and 2
    @Published var indexBy1:Bool = false
    @Published var indexBy2:Bool = false
}




//                if guestNodeList.count > 1{
//
//
//                    if guestNodeList[1].position.x != locationQueue2!.position.x{
//                        guestNodeList[1].position = locationQueue2!.position
//                        var nextMovingSecondSprite = scene?.childNode(withName: guestNodeList[1].name)
//                        guestSpawned.indexBy1 = true
//                        let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[1].duration)
//                        let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[1].duration)
//                        let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[1].duration)
//                        let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[1].duration)
//                        let fifthMove = SKAction.move(to: locationQueue2!.position, duration: guestNodeList[1].duration)
//                        let guestNodeFinalSize: CGFloat = 1.4
//                        let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[1].duration)
//                        let sequenceMove = SKAction.sequence([ firstMove, secondMove , thirdMove, fourthMove,fifthMove ])
//                        let groupAction = SKAction.group([sequenceMove, scaleAction])
//                        nextMovingSecondSprite!.run(groupAction)
//                    }
//
//
//                    if guestNodeList.count == 3{
//                        if guestNodeList[2].position.x != locationQueue2!.position.x{
//                            guestNodeList[2].position = locationQueue3!.position
//                            var nextMovingThirdSprite = scene?.childNode(withName: guestNodeList[2].name)
//
//                            let firstMove = SKAction.move(to: moveLocation1!.position, duration: guestNodeList[2].duration)
//                            let secondMove = SKAction.move(to: moveLocation2!.position, duration: guestNodeList[2].duration)
//                            let thirdMove = SKAction.move(to: moveLocation3!.position, duration: guestNodeList[2].duration)
//                            let fourthMove = SKAction.move(to: locationQueue3!.position, duration: guestNodeList[2].duration)
//
//                            let guestNodeFinalSize: CGFloat = 1.4
//                            let scaleAction = SKAction.scale(to: guestNodeFinalSize, duration: guestNodeList[2].duration)
//
//                            let sequenceMove = SKAction.sequence([ fourthMove ])
//
//                            let groupAction = SKAction.group([sequenceMove, scaleAction])
//
//                            nextMovingThirdSprite!.run(groupAction)
//                        }
//                    }
//
//
//
//                }
