//
//  GuiderView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI
import SpriteKit

struct GuiderView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    //this section is defining the entire gamescreen

    var scene = SKScene(fileNamed: "GuiderGameScene.sks")
    var body: some View {
        
        ZStack{
            
            VStack{
                
                SpriteView(scene: scene!).ignoresSafeArea()
                  
            }.ignoresSafeArea().onAppear(){
                scene?.size = CGSize(width: screenWidth, height: screenHeight)
                scene?.scaleMode = .fill
                scene?.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
            }
//            VStack{
//                HStack{
//                    Text("Esc").font(.title3)
//                    Spacer()
//                }
//                Spacer()
//            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct GuiderView_Previews: PreviewProvider {
    static var previews: some View {
        GuiderView().previewInterfaceOrientation(.landscapeRight)
    }
}

