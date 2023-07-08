//
//  Co_SpaceApp.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI

@main
struct Co_SpaceApp: App {
    var body: some Scene {
        WindowGroup {
            RoleRevealView(game: MainGame())
        }
    }
}

