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
