//
//  DumpCodeTest.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 01/07/23.
//

import Foundation
//    func moveGuestToSeat(numberSeat:Int, signSeat:String) {
//        self.seatClickable = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.seatClickable = true
//        }
//
//        if (queueList.count > 0){
//            for i in 0...(queueList.count-1) {
//                if (queueList[i].queue > 1){
//                    let nextQueue = queueList[i].queue - 1
//                    // Animation jalannya
//                    let moveAction = SKAction.move(to: locationList[nextQueue - 1].position, duration: 1.0)
//                    queueList[i].guest.run(moveAction)
//
//                    // Perbarui queuenya yang sekarang
//                    queueList[i].queue = nextQueue
//                }
//                else {
//                    // Kalo guestnya udah dikasih tanda
//                    if (!guestLeave){
//                        if signSeat == "circleseat"{
//                            print("duduk ke kursi \(signSeat) number \(numberSeat)")
//                            //pergi ke tempat duduk
//                            let moveToSeat = SKAction.move(to: seatCircleNodeList[numberSeat].position, duration: 0.4)
//                            queueList[i].guest.run(moveToSeat)
//
//                            //CHANGE THE TEXTURE
//
//                            seatCircleNodeDict["seatcircle\(numberSeat)"] = queueList[i].guest
//                            startTimerGuestSeat(for: "seatcircle\(numberSeat)", duration: 2.0, sprite: queueList[i].guest as! SKSpriteNode)
//                        }
//                        else if signSeat == "squareseat"{
//                            print("duduk ke kursi \(signSeat) number \(numberSeat)")
//                            //pergi ke tempat duduk
//                            let moveToSeat = SKAction.move(to: seatSquareNodeList[numberSeat].position, duration: 0.4)
//                            queueList[i].guest.run(moveToSeat)
//                            seatSquareNodeDict["seatsquare\(numberSeat)"] = queueList[i].guest
//                        }
//                        else if signSeat == "triangleseat"{
//                            print("duduk ke kursi \(signSeat) number \(numberSeat)")
//                            //pergi ke tempat duduk
//                            let moveToSeat = SKAction.move(to: seatTriangleNodeList[numberSeat].position, duration: 0.4)
//                            queueList[i].guest.run(moveToSeat)
//                            seatTriangleNodeDict["seattriangle\(numberSeat)"] = queueList[i].guest
//                        }
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
////                        self.queueList[i].guest.removeFromParent()
//                        self.queueList.removeFirst()
//                    }
//                }
//            }
//
//            let firstQueueGuestTime = queueList[0].guest.userData?.value(forKey: "kesabaran") as? Int
//            timerRenewal(seconds: Int(firstQueueGuestTime!))
//        }
//    }
