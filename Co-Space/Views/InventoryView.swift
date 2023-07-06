import SwiftUI
import SpriteKit

struct InventoryView: View {
    @ObservedObject var game: MainGame
    var scene = SKScene(fileNamed: "InventoryGameScene.sks") as! InventoryGameScene
    var body: some View {
        ZStack{
            VStack{
                SpriteView(scene: scene).ignoresSafeArea()
            }
            .onAppear{
                scene.game = self.game
                scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                scene.scaleMode = .fill
                scene.backgroundColor = SKColor(named: "DarkPurple") ?? .blue
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}


struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(game: MainGame()).previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
