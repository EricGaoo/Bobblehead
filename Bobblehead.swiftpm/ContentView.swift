import SwiftUI
import Foundation

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink(destination: Posture()) {
                        Image("Airpod")
                            .scaleEffect(0.5)
                            .position(x: 196.5, y: 467)
                    }
                }
                Image("Title")
                    .scaleEffect(0.5)
                    .position(x: 197, y: 253)
                
            }
        }
        
    }
}

