import SwiftUI
import Foundation

struct PreSettings: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                if (verticalSizeClass == .compact) {
                    Image("SettingsLand")
                        .scaleEffect(0.5)
                        .position(x:363, y:180)
                } else {
                    Image("Settings")
                        .scaleEffect(0.5)
                        .position(x:196.5, y:396)
                }
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: Setup()) {
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(Color.black)
                                    .padding(12)
                            }
                        }
                        .padding(12)
                        Spacer()
                    }
                }

            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
