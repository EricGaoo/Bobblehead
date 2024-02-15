//
//  Graph.swift
//  Bobblehead
//
//  Created by Eric Gao on 2023-12-16.
//

import SwiftUI
import Charts
import Combine


enum Constants {
    static let updateInterval = 0.0001
}

struct GraphData: Identifiable{
    let id = UUID()
    let interval: Double
    let angle: Double
}

struct Graph: View {
    @State public var motionHandler = MotionManager()
    @State public var data: [GraphData] = []
    @State public var counter = 0.0
    @State public var stop = 0
    
    let timer = Timer.publish(every: TimeInterval(Constants.updateInterval), tolerance: 0.01, on: .current, in: .common).autoconnect()
    
    var body: some View {
        
        @Environment(\.dismiss) var dismiss
        
        let cfURL = Bundle.main.url(forResource: "Satoshi-Regular", withExtension: "otf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        NavigationView {
            ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Move your head and check").foregroundStyle(Color.black)
                        .font(Font.custom("Satoshi-Regular", size: 19))
                        .padding(.top, 20)
                    Text("out the graph data!").foregroundStyle(Color.black)
                        .font(Font.custom("Satoshi-Regular", size: 19))
                        .padding(.bottom, 20)
                    Chart(data) { dat in
                        LineMark(
                            x: .value("Interval", dat.interval),
                            y: .value("Angle", dat.angle)
                        )
                    }
                }
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: PreSettings()) {
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
                .onReceive(timer) { _ in
                    updateData()
            }
        }
        .navigationBarBackButtonHidden(true)
        
        }
    public func updateData() {
        if stop == 0 {
            counter += 1;
            let updatePitch = motionHandler.pitch * 100
            let updatedData = GraphData(interval: counter, angle: updatePitch)
            data.append(updatedData)
        }


    }

}



