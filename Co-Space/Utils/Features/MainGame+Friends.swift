//
//  MainGame+Friends.swift
//  Co-Space
//
//  Created by Neilson Soeratman on 27/06/23.
//

import Foundation
import GameKit

extension MainGame {
    /// Presents the friends request view controller.
    /// - Tag:addFriends
    func addFriends() {
        if let viewController = rootViewController {
            do {
                try GKLocalPlayer.local.presentFriendRequestCreator(from: viewController)
            } catch {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
}
