//
//  MainmenuView.swift
//  Co-Space
//
//  Created by Achmad Rijalu on 20/06/23.
//

import SwiftUI

struct MainmenuView: View {
    @State var dragAmount:CGFloat = 0
    @State var showSliderText = true
    @State private var isNextScreenActive = false
    @State private var isDragging = false
    
    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                VStack {
                    Spacer()
                    Text("Co-Space").font(.largeTitle).fontWeight(.heavy).foregroundColor(Color("RedColor"))
                    Spacer()
                    //Slider Here
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 50, style: .continuous).frame(width: geo.size.width/2 ).foregroundColor(Color.white).foregroundStyle(.ultraThickMaterial).blendMode(.plusLighter)
                        HStack{
                            Image(systemName: "arrow.right.circle").font(.system(size: geo.size.width/12)).offset(x: self.dragAmount ).simultaneousGesture(DragGesture().onChanged({ value in
                               
                                if value.translation.width > 0 && value.translation.width < geo.size.width / 2.6{
                                    self.dragAmount = value.translation.width
                                }
                            }
                                                                                                                                                                                  ).onEnded{ value in
                                if dragAmount >= geo.size.width/2.9{
                                    //do some action
                                    print("Navigate to the game room")
                                    isNextScreenActive = true
                                    withAnimation(.spring()){
                                        dragAmount = 0
                                        showSliderText = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        showSliderText = true
                                    }
                                    
                                    
                                }
                                else{
                                    withAnimation(.spring()){
                                        dragAmount = 0
                                        showSliderText = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        showSliderText = true
                                    }
                                    
                                }
                            })
                            if showSliderText && dragAmount <= geo.size.width / 13 {
                                withAnimation(.easeIn(duration: 2)){
                                    Text("Slide to Create Game Room").foregroundColor(.black)
                                    
                                }
                                
                            }
                            
                            
                        }
                        //                        Text("Slide to Create Room").foregroundColor(.black)
                    }.frame(width: 10, height: 62).background(.red)
                    

                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color("BackgroundColor"))
                .navigationBarHidden(true)
                .background(
                    NavigationStack {
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $isNextScreenActive, destination: {
                       GameRoomView()
                   })
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
