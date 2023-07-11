//
//  GameRoomView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 10/07/23.
//

import SwiftUI
import MultipeerConnectivity
struct GameRoomView: View {
    @EnvironmentObject var multipeerSession: SpaceMultipeerSession
    @EnvironmentObject  var gameRoom: GameRoom
    @State private var isInviteAlertPresented = false
    @State private var invitedPeer: MCPeerID?
    let gameCode = Int(arc4random_uniform(9000) + 1000)
    //Randomize the int game room code
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Your Game Code!").foregroundColor(.white).font(.title)
                    Spacer()
                }.padding(.top, 20)
                
                HStack{
                    Text(String(gameRoom.gameCode)).font(.title2).foregroundColor(.white)
                }.padding(.top, 12)
                
                if multipeerSession.paired{
                    Text("Paired")
                    Text("Connected Peers:")
                        .font(.headline)
                    
                    List(multipeerSession.availablePeers.filter { $0.displayName != multipeerSession.myPeerID?.displayName }, id: \.self) { peer in
                        Text(peer.displayName)
                    }
                }
                else{
                    Text("Not paired")
                }
                
                //                HStack {
                //                    List(multipeerSession.availablePeers, id: \.self) { peer in
                //                        Button(peer.displayName == "Player" ? "Hahah" : peer.displayName) {
                //                            guard let session = multipeerSession.session else {return}
                //                            guard let serviveBrowser = multipeerSession.serviceBrowser else {return}
                //                            serviveBrowser.invitePeer(peer, to: session, withContext: nil, timeout: 30)
                //                        }
                //                    }
                //                }
                
            }
            
        }.background(Color("DarkPurple")).onAppear {
            gameRoom.generateGameCode()
        }
        
    }
    
    
}


//struct GameRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameRoomView(gameRoom: GameRoom()).previewInterfaceOrientation(.landscapeLeft)
//    }
//}
