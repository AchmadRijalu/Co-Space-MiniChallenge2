import Foundation
import MultipeerConnectivity

import SwiftUI
//class GameRoom {
//    let maxPlayers: Int = 4
//    var players: [MCPeerID] = []
//
//    var isFull: Bool {
//        return players.count >= maxPlayers
//    }
//
//    func addPlayer(_ player: MCPeerID) {
//            if players.count < 4 {
//                players.append(player)
//            }
//        }
//
//    func removePlayer(_ player: MCPeerID) {
//        if let index = players.firstIndex(of: player) {
//            players.remove(at: index)
//        }
//    }
//
//    func removeAllPlayers() {
//        players.removeAll()
//    }
//
//    func isPlayerInGameRoom(_ player: MCPeerID) -> Bool {
//        return players.contains(player)
//    }
//}

//
//  MultipeerSession.swift
//  Undermask
//
//  Created by William Layadi on 17/06/23.
//

import SwiftUI
import MultipeerConnectivity

struct MultipeerSession: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



class GameRoom: ObservableObject {
    let maxPlayers: Int = 4
    @Published var players: [MCPeerID] = []
    @Published var gameCode: String = ""
    
    var isFull: Bool {
        return players.count >= maxPlayers
    }
    
    func addPlayer(_ player: MCPeerID) {
        if players.count < maxPlayers {
            players.append(player)
        }
    }
    
    func removePlayer(_ player: MCPeerID) {
        if let index = players.firstIndex(of: player) {
            players.remove(at: index)
        }
    }
    
    func removeAllPlayers() {
        players.removeAll()
    }
    
    func isPlayerInGameRoom(_ player: MCPeerID) -> Bool {
        return players.contains(player)
    }
    
    func generateGameCode() {
        // Generate the game code here
        // Assign the generated code to the gameCode property
        // For example:
        let randomCode = String(format: "%04d", Int.random(in: 0..<10000))
        gameCode = randomCode
    }
}

protocol ColorServiceDelegate {
    
    func connectedDevicesChanged(manager : SpaceMultipeerSession, connectedDevices: [String])
    func colorChanged(manager : SpaceMultipeerSession, colorString: String)
    
}


enum Move: String, CaseIterable, CustomStringConvertible {
    case rock, paper, scissors, unknown
    
    var description : String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        default: return "Thinking"
        }
    }
}



class SpaceMultipeerSession: NSObject, ObservableObject {
    private let serviceType = "space-start"
    public var myPeerID: MCPeerID?
    
    public var serviceAdvertiser: MCNearbyServiceAdvertiser?
    public var serviceBrowser: MCNearbyServiceBrowser?
    public var session: MCSession?
    
    
    //TAMBAHAN
    var delegate : ColorServiceDelegate?
    @Published var gameRoom: GameRoom
    @Published var availablePeers: [MCPeerID] = []
    //    @Published var receivedMove: Move = .unknown
    @Published var colorString : String = ""
    @Published var recvdInvite: Bool = false
    @Published var recvdInviteFrom: MCPeerID? = nil
    @Published var paired: Bool = false
    @Published var invitationHandler: ((Bool, MCSession?) -> Void)?
    init(username: String) {
        
        gameRoom = GameRoom()
        
        super.init()
        
        let displayName = UIDevice.current.name
        let peerID = MCPeerID(displayName:  displayName)
        self.myPeerID = peerID
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none )
        
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        guard let session = session else {return}
        session.delegate = self
        guard let serviceBrowser = serviceBrowser else {return}
        guard let serviceAdvertiser = serviceAdvertiser else {return}
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
        
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        guard let serviceBrowser = serviceBrowser else {return}
        guard let serviceAdvertiser = serviceAdvertiser else {return}
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    func send(
        //        move: Move
        colorName:String
        
    ) {
        guard let session = session else {return}
        if session.connectedPeers.count > 0 {
            do {
                try session.send(colorName.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
        
    }
}
extension SpaceMultipeerSession: MCSessionDelegate{
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        //        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        switch state {
        case MCSessionState.notConnected:
            // Peer disconnected
            DispatchQueue.main.async {
                self.paired = false
            }
            // Peer disconnected, start accepting invitaions again
            guard let serviceAdvertiser = serviceAdvertiser else {return}
            serviceAdvertiser.startAdvertisingPeer()
            break
        case MCSessionState.connected:
            // Peer connected
            DispatchQueue.main.async {
                self.paired = true
            }
            for connectedPeer in session.connectedPeers {
                print("Connected peer: \(connectedPeer.displayName)")
            }
            // We are paired, stop accepting invitations
            //            serviceAdvertiser.stopAdvertisingPeer()
            //            break
        default:
            // Peer connecting or something else
            DispatchQueue.main.async {
                self.paired = false
            }
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        
        
        //        if let string = String(data: data, encoding: .utf8), let move = Move(rawValue: string) {
        ////            log.info("didReceive move \(string)")
        //            // We received a move from the opponent, tell the GameView
        //            DispatchQueue.main.async {
        //                self.receivedMove = move
        //            }
        //        } else {
        ////            log.info("didReceive invalid value \(data.count) bytes")
        //        }
        
        
        //TAMBAHAN
        DispatchQueue.main.async {
            let str = String(data: data, encoding: .utf8)!
            self.delegate?.colorChanged(manager: self, colorString: str)
        }
        //TAMBAHAN
        //TAMBAHAN 2
        DispatchQueue.main.async {
            self.colorString = String(data: data, encoding: .utf8)!
            //            self.delegate?.colorChanged(manager: self, colorString: str)
        }
        //TAMBAHAN 2
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
    
}



extension SpaceMultipeerSession: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        //TODO: Tell the user something went wrong and try again
        //        log.error("ServiceBroser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        //        log.info("ServiceBrowser found peer: \(peerID)")
        NSLog("%@", "ServiceBrowser found peer: \(peerID)")
        // Add the peer to the list of available peers
        DispatchQueue.main.async {
            //            self.availablePeers.removeAll(where: {
            //                $0 == peerID
            //            })
            
            //            self.availablePeers.removeAll()
            self.availablePeers.append(peerID)
        }
        
        
        //        let peers = session.connectedPeers
        //        self.availablePeers = peers
        
        //        if peers.contains(peerID){
        //        //do some work
        //        }
        
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        //        log.info("ServiceBrowser lost peer: \(peerID)")
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0 == peerID
            })
        }
    }
}

extension SpaceMultipeerSession : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        //        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        DispatchQueue.main.async {
            // Tell PairView to show the invitation alert
            self.recvdInvite = true
            // Give PairView the peerID of the peer who invited us
            self.recvdInviteFrom = peerID
            // Give PairView the `invitationHandler` so it can accept/deny the invitation
            self.invitationHandler = invitationHandler
        }
    }
    
}
