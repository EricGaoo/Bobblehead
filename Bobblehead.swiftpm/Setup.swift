import SwiftUI
import Foundation

struct Setup: View {
    
    var body: some View {
        let cfURL = Bundle.main.url(forResource: "Satoshi-Regular", withExtension: "otf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let cfeURL = Bundle.main.url(forResource: "Satoshi-Black", withExtension: "otf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(cfeURL, CTFontManagerScope.process, nil)
        
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Hold your phone like this: ")
                        .font(Font.custom("Satoshi-Regular", size: 20))
                        .foregroundStyle(.black)
                        .padding(.top, 20)
                    Spacer()
                    HStack{
                        Text("Put your LEFT")
                            .font(Font.custom("Satoshi-Regular", size: 20))
                            .foregroundStyle(.black)
                        Text("AirPod")
                            .font(Font.custom("Satoshi-Black", size: 20))
                            .foregroundStyle(.black)
                        Text("back in the case")
                            .font(Font.custom("Satoshi-Regular", size: 20))
                            .foregroundStyle(.black)
                    }
                    .padding(13)
                }
                Image("Setup")
                    .scaleEffect(0.5)
                    .position(x: 366, y:282)
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: Joke()) {
                            Image(systemName: "arrow.right")
                                .padding(12)
                        }
                    }
                    .padding(12)
                    Spacer()
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
