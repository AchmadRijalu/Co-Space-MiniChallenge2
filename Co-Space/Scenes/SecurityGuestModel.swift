//
//  SecurityGuestModel.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 04/07/23.
//

import Foundation
struct GuestSecurity {
    var name: String?
    var imageName: String?
}

class GuestSecurityDictionary {
    var guestList:[GuestSecurity]=[]
    init() {
        guestList = [
            GuestSecurity(name:"Guest-1", imageName: "guest-1"),
            GuestSecurity(name:"Guest-2", imageName: "guest-2"),
            GuestSecurity(name:"Guest-3", imageName: "guest-3"),
            GuestSecurity(name:"Guest-4", imageName: "guest-4"),
            GuestSecurity(name:"Guest-5", imageName: "guest-5"),
            GuestSecurity(name:"Guest-6", imageName: "guest-6"),
            GuestSecurity(name:"Guest-7", imageName: "guest-7"),
            GuestSecurity(name:"Guest-8", imageName: "guest-8"),
        ]
    }
}
