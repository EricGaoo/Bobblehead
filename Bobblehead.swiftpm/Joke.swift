import SwiftUI

import Foundation



struct Joke: View {
    
    var body: some View {
        
        let cfURL = Bundle.main.url(forResource: "Satoshi-Regular", withExtension: "otf")! as CFURL
        
        let _ = CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        NavigationView {
            
            ZStack {
                
                Color.white
                
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Me: Mom can we get")
                    
                        .font(Font.custom("Satoshi-Regular", size: 19))
                    
                        .foregroundStyle(.black)
                    
                    Text("Apple Vision Pro?")
                    
                        .font(Font.custom("Satoshi-Regular", size: 19))
                    
                        .foregroundStyle(.black)
                    
                        .padding(.bottom, 15)
                    
                    Text("Mom: No we have that")
                    
                        .font(Font.custom("Satoshi-Regular", size: 19))
                    
                        .foregroundStyle(.black)
                    
                    Text("at home")
                    
                        .font(Font.custom("Satoshi-Regular", size: 19))
                    
                        .foregroundStyle(.black)
                    
                        .padding(.bottom, 15)
                    
                    NavigationLink(destination: AR()) {
                        
                        Text("Apple Vision Pro at home")
                        
                            .font(Font.custom("Satoshi-Black", size: 18))
                        
                            .padding(20)
                        
                            .foregroundStyle(.white)
                        
                            .background(.black)
                        
                            .clipShape(Capsule())
                        
                    }
                    
                }
                
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
        
    }
    
}
