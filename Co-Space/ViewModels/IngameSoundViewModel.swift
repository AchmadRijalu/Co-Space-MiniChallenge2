//
//  IngameSoundViewModel.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 13/07/23.
//

import Foundation
import AVFoundation

class IngameViewModel{
    static var shared = IngameViewModel()
    var mainMenuBacksound = AVAudioPlayer()
    var gameStartBacksound = AVAudioPlayer()
    
    
    func playBacksoundSoundMultipleTimes(count: Int) {
        guard let url = Bundle.main.url(forResource: "backsound", withExtension: "wav") else { return }
        do {
            mainMenuBacksound = try AVAudioPlayer(contentsOf: url)
            mainMenuBacksound.numberOfLoops = count - 1
            mainMenuBacksound.prepareToPlay()
            mainMenuBacksound.play()

        } catch let error {
            print("error")
            print(error.localizedDescription)
        }
    }
    
    func playGameStartSoundMultipleTimes(count: Int) {
        guard let url = Bundle.main.url(forResource: "backsound-play-screen", withExtension: "wav") else { return }
        do {
            gameStartBacksound = try AVAudioPlayer(contentsOf: url)
            gameStartBacksound.numberOfLoops = count - 1
            gameStartBacksound.prepareToPlay()
            gameStartBacksound.play()

        } catch let error {
            print("error")
            print(error.localizedDescription)
        }
    }
    
//    let player = IngameViewModel.shared.gameStartBacksound
}
