//
//  GeneratePengunjung.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 22/06/23.
//

import SpriteKit
import GameplayKit

class GeneratePengunjung{
    let scene = SKScene(fileNamed: "SecurityGameScene.sks")
    var pengunjungGenerator: SKNode?
    var listpengunjung: [Pengunjung] = []
    var counterName : Int = 1
    func generatePengunjung() -> SKNode{
        let generator = scene?.childNode(withName: "spawnLocation")
        let pengunjungdisiapkan = listpengunjung.randomElement()
        let spawnnote = SKSpriteNode(texture: SKTexture(imageNamed: (pengunjungdisiapkan?.ImageName!)!))
        spawnnote.position = generator!.position
        spawnnote.name = "pengunjung\(counterName)"
        spawnnote.size = CGSize(width: 100, height: 100)
        let tags: NSMutableDictionary = [
            "nama":pengunjungdisiapkan?.nama ?? "no-name",
            "kesabaran":pengunjungdisiapkan?.kesabaranSecurity ?? 0,
        ]
        spawnnote.userData = tags
        counterName += 1
        print(spawnnote)
        if counterName == 5 {
            counterName = 1
        }
        return spawnnote
        
    }
    init() {
        listpengunjung = GuestDictionary().guestList
    }
}
