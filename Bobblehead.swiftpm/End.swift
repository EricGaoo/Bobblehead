import SwiftUI
import Foundation

struct End: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            if (verticalSizeClass == .compact) {
                Image("EndMessage")
                    .scaleEffect(0.5)
                    .rotationEffect(.degrees(90))
            } else {
                Image("EndMessage")
                    .scaleEffect(0.5)
            }
            
        }
    }
}
