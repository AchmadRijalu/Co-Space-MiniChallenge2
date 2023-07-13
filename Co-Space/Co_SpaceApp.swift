//
//  Co_SpaceApp.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI

@main
struct Co_SpaceApp: App {
    @StateObject var gameStart = GameStartViewModel()
    var body: some Scene {
        WindowGroup {
//            MainmenuView()
            RoleRevealView(game: MainGame()).environmentObject(gameStart)
        }
    }
}

