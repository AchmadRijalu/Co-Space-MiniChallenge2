import SwiftUI
import SpriteKit

struct InventoryView: View {
    var scene = SKScene(fileNamed: "InventoryGameScene.sks")
    var body: some View {
        SpriteView(scene: scene!)
            .ignoresSafeArea()
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView().previewInterfaceOrientation(.landscapeRight)
            .ignoresSafeArea()
    }
}
