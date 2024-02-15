import SwiftUI
import Foundation

struct Posture: View {
    @State private var motionHandler = MotionManager()
    @State public var stop = 0
    
    var body: some View {
        let cfURL = Bundle.main.url(forResource: "Satoshi-Regular", withExtension: "otf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        NavigationStack {
            TimelineView(.animation) { timeline in
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                        Image("Steve Head")
                            .scaleEffect(0.5)
                            .rotationEffect(.degrees(motionHandler.pitch*45), anchor: .center)
                            .position(x: 208.3, y: 490.65)
                        Image("Steve Body")
                            .scaleEffect(0.5)
                            .position(x: 191.02, y: 661.705)
                        Text("Move your head \n up and down!").foregroundStyle(Color.black)
                            .position(x: 197.5, y: 131)
                            .font(Font.custom("Satoshi-Regular", size: 22))
                    HStack {
                        if (stop == 0) {
                            Text(String(format: "%.0f", (motionHandler.pitch*55)))
                                .foregroundStyle(Color.gray)
                                .font(Font.custom("Satoshi-Regular", size: 39))
                        }
                        Text("°")
                            .foregroundStyle(Color.gray)
                    }
                    .position(x: 196.5, y: 287)
                    if (stop == 0) {
                        if (motionHandler.pitch < -0.8) {
                            Text("ouch").foregroundStyle(Color.gray)
                                .font(Font.custom("Satoshi-Regular", size: 10))
                    }
                    }

                        VStack {
                            HStack {
                                Spacer()
                                NavigationLink(destination: Graph()) {
                                    Image(systemName: "arrow.right")
                                        .padding(12)
                                }.simultaneousGesture(TapGesture().onEnded{
                                    stop = 1
                                })
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
