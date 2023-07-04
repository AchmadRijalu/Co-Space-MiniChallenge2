//
//  MainmenuView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct MainmenuView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State var dragAmount:CGFloat = 0
    @State var showSliderText = true
    @State private var isNextScreenActive = false
    @State private var isDragging = false
    var scene = SKScene(fileNamed: "MainMenuGameScene.sks")
    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                VStack {
                    ZStack{
                        VStack{
                            
                            SpriteView(scene: scene!).ignoresSafeArea()
                            
                        }.ignoresSafeArea().onAppear(){
                            scene?.size = CGSize(width: screenWidth, height: screenHeight)
                            scene?.scaleMode = .fill
                            scene?.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
                        }

                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color("DarkPurple"))
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        destination: SecurityView(),
                        isActive: $isNextScreenActive,
                        label: EmptyView.init
                    )
                    .navigationBarBackButtonHidden(true)
                )
                
            }
        }.onAppear(){
            self.dragAmount = 0
        }.onDisappear {
            dragAmount = 0
            isDragging = false
        }
    }
}

struct MainmenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainmenuView().previewInterfaceOrientation(.landscapeRight)
    }
}
