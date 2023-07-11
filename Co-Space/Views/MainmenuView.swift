//
//  MainmenuView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit
import MultipeerConnectivity
struct MainmenuView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State var dragAmount:CGFloat = 0
    @State var showSliderText = true
    @State private var isNextScreenActive = false
    @State private var isDragging = false
    var scene = SKScene(fileNamed: "MainMenuGameScene.sks") as! MainMenuGameScene
    
    @StateObject var game: MainGame = MainGame()
    
    //MARK: - Multipeer Functionality Start Here
    @State private var navigateToAnotherView = false
    @EnvironmentObject var sessionName: SpaceMultipeerSession
    
    @State var gameCode:String = ""
    
    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                if !sessionName.paired{
                    VStack {
                        ZStack{
                            
                            VStack{
                                SpriteView(scene: scene).ignoresSafeArea()
                                
                            }.ignoresSafeArea()
                                .task{
                                    scene.game = game
                                    scene.size = CGSize(width: screenWidth, height: screenHeight)
                                    scene.scaleMode = .fill
                                    scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
                                }
                            VStack(alignment: .trailing){
                                HStack{
                                    Spacer()
                                    VStack{
                                        TextField("Game Code", text: $gameCode)
                                            .frame(width: 120)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        Button("Enter Game Room"){
                                            
                                        }.padding(6).foregroundColor(.white).background(Color("DarkPurple")).cornerRadius(12)
                                    }
                                  
                                }.padding([.trailing, .top], 12)
                                Spacer()
                            }
                        }
                    }.alert("Received an invite from \(sessionName.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $sessionName.recvdInvite) {
                        Button("Accept invite") {
                            if (sessionName.invitationHandler != nil) {
                                sessionName.invitationHandler!(true, sessionName.session)
                            }
                        }
                        Button("Reject invite") {
                            if (sessionName.invitationHandler != nil) {
                                sessionName.invitationHandler!(false, nil)
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(Color("DarkPurple"))
                    .navigationBarHidden(true)
                    .background(
                        //                    NavigationLink(
                        ////                        destination: RoleRevealView(game: game),
                        //                        destination: ,
                        //                        isActive: $game.playingGame,
                        //                        label: EmptyView.init
                        //                    )
                        NavigationLink(destination: GameRoomView().environmentObject(GameRoom()), isActive: $navigateToAnotherView) {
                        }
                            .navigationBarBackButtonHidden(true)
                    )
                }
                else{
                    GameRoomView()
                }
                
            }
        }.onAppear{
            //Multipeer Activity
            
            NotificationCenter.default.addObserver(forName: Notification.Name("NavigatetoGameRoom"), object: nil, queue: nil) { _ in
                navigateToAnotherView = true
            }
            
            
            self.dragAmount = 0
            scene.game = self.game
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }.onDisappear {
            dragAmount = 0
            isDragging = false
        }
        
        .navigationBarBackButtonHidden(true)
    }
}



struct MainmenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainmenuView().previewInterfaceOrientation(.landscapeRight)
    }
}
