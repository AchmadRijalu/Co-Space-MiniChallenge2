//
//  Co_SpaceApp.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI

@main
struct Co_SpaceApp: App {
    @StateObject var multipeerSession = SpaceMultipeerSession(username: "DefaulUsername")
    var body: some Scene {
        WindowGroup {
            MainmenuView().environmentObject(multipeerSession)
        }
    }
}
