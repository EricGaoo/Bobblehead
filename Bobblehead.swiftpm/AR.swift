import SwiftUI
import ARKit
import RealityKit

struct AR: View {
    
    @State public var motionHandler = MotionManager()
    @State private var code = 0
    @State private var x = 0.000
    @State private var size: Float = 0.02;
    // 0: pointer, 1: red, 2: blue, 3: yellow, 4: black, 5: eraser
    

    var body: some View {
        NavigationView {
            TimelineView(.animation) { timeline in
                ZStack {
                    ARViewContainer(code: $code, x: $x, size: $size)
                    HStack {
                        VStack {
                            Button(action: { //red
                                if code == 1 {
                                    code = 0
                                } else {
                                    code = 1
                                    x += 0.001
                                }
                                
                            }) {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            Button(action: { //blue
                                if code == 2 {
                                    code = 0
                                } else {
                                    code = 2
                                    x += 0.001
                                }
                                
                            }) {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                            Button(action: { //yellow
                                if code == 3 {
                                    code = 0
                                } else {
                                    code = 3
                                    x += 0.001
                                }
                                
                            }) {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.yellow)
                                    .padding()
                            }
                            Button(action: { //black
                                if code == 4 {
                                    code = 0
                                } else {
                                    code = 4
                                    x += 0.001
                                }
                                
                            }) {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            Button(action: { //eraser
                                if code == 5 {
                                    code = 0
                                } else {
                                    code = 5
                                    x += 0.001
                                }
                                
                            }) {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.init(red: 1, green: 0.635, blue: 0.945))
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                    VStack {
                        Text("Click a colour/eraser to use it. Click on it again when you want to stop!")
                            .padding(10)
                        Spacer()
                        HStack {
                            Slider(value: $size, in: 0.00625...0.04)
                                .frame(width: 200)
                                .padding()
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: End()) {
                                Image(systemName: "arrow.right")
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



struct ARViewContainer: UIViewRepresentable {
    @State public var motionHandler = MotionManager()
    @Binding var code: Int
    @Binding var x: Double
    @Binding var size: Float
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        //MacPaint:

        let anchorMP = AnchorEntity(world: SIMD3<Float>(0, 0.04, -0.5))
        
        var materialMP = SimpleMaterial()
        materialMP.color = .init(tint: .white.withAlphaComponent(1),
                               texture: .init(try! .load(named: "MacPaint")))
        materialMP.roughness = .float(0)
        
        let MPEntity = ModelEntity(mesh: .generatePlane(width: 0.5, height: 0.25, cornerRadius: 0.0125), materials : [materialMP])
        
        MPEntity.setParent(anchorMP)
        arView.scene.anchors.append(anchorMP)
        
        //Steve Jobs with Mac:
        
        let anchorSJ = AnchorEntity(world: SIMD3<Float>(0.32, 0.04, -0.4))
        anchorSJ.transform.rotation = simd_quatf(angle: .pi/2, axis: [0,-0.5,0])
        
        var materialSJ = SimpleMaterial()
        materialSJ.color = .init(tint: .white.withAlphaComponent(1),
                                 texture: .init(try! .load(named: "SteveJobsWithMacPaint")))
        materialSJ.roughness = .float(0)
        
        let SJEntity = ModelEntity(mesh: .generatePlane(width: 0.195, height: 0.25, cornerRadius: 0.0125), materials: [materialSJ])
        SJEntity.setParent(anchorSJ)
        arView.scene.anchors.append(anchorSJ)
        
        //TimCook with Apple Vision Pro
        
        let anchorTC = AnchorEntity(world: SIMD3<Float>(-0.35, 0.04, -0.4))
        anchorTC.transform.rotation = simd_quatf(angle: .pi/2, axis: [0,0.5,0])
        
        var materialTC = SimpleMaterial()
        materialTC.color = .init(tint: .white.withAlphaComponent(1),
                                 texture: .init(try! .load(named: "TimCookAppleVP")))
        materialTC.roughness = .float(0)
        
        let TCEntity = ModelEntity(mesh: .generatePlane(width: 0.25, height: 0.25, cornerRadius: 0.0125), materials: [materialTC])
        TCEntity.setParent(anchorTC)
        arView.scene.anchors.append(anchorTC)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if (code == 0) {
            let meshP = MeshResource.generatePlane(width: size, height: size, cornerRadius: size/2)
            let materialP = SimpleMaterial(color: .init(red: 0, green: 0, blue: 0, alpha: 0.8), roughness: 0, isMetallic: false)
            let modelP = ModelEntity(mesh: meshP, materials: [materialP])
            
            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.496+x)))
            anchor.children.append(modelP)
            
            // Add the horizontal plane anchor to the scene
            uiView.scene.anchors.append(anchor)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                uiView.scene.removeAnchor(anchor)
            }
        }
        
        if (code != 0) {
            let mesh = MeshResource.generatePlane(width: size, depth: size, cornerRadius: size/2)
            if (code == 1) {
                let material = SimpleMaterial(color: .red, roughness: 0, isMetallic: false)
                let model = ModelEntity(mesh: mesh, materials: [material])
                model.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.499+x)))
                anchor.children.append(model)
                
                // Add the horizontal plane anchor to the scene
                uiView.scene.anchors.append(anchor)
            } else if (code == 2) {
                let material = SimpleMaterial(color: .blue, roughness: 0, isMetallic: false)
                let model = ModelEntity(mesh: mesh, materials: [material])
                model.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.499+x)))
                anchor.children.append(model)
                
                // Add the horizontal plane anchor to the scene
                uiView.scene.anchors.append(anchor)
            } else if (code == 3) {
                let material = SimpleMaterial(color: .yellow, roughness: 0, isMetallic: false)
                let model = ModelEntity(mesh: mesh, materials: [material])
                model.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.499+x)))
                anchor.children.append(model)
                
                // Add the horizontal plane anchor to the scene
                uiView.scene.anchors.append(anchor)
            } else if (code == 4) {
                let material = SimpleMaterial(color: .black, roughness: 0, isMetallic: false)
                let model = ModelEntity(mesh: mesh, materials: [material])
                model.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.499+x)))
                anchor.children.append(model)
                
                // Add the horizontal plane anchor to the scene
                uiView.scene.anchors.append(anchor)
            } else if (code == 5) {
                let meshE = MeshResource.generatePlane(width: size, depth: size)
                let materialE = SimpleMaterial(color: .init(red: 1, green: 0.635, blue: 0.945, alpha: 1), roughness: 0, isMetallic: false)
                let modelE = ModelEntity(mesh: meshE, materials: [materialE])
                
                modelE.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                let material = SimpleMaterial(color: .init(red: 1, green: 1, blue: 1, alpha: 1), isMetallic: false)
                let model = ModelEntity(mesh: mesh, materials: [material])
                model.transform.rotation = simd_quatf(angle: .pi/2, axis: [1,0,0])
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.499+x)))
                let anchorE = AnchorEntity(world: SIMD3<Float>(Float(-(motionHandler.yaw)), Float(motionHandler.pitch + 0.3), Float(-0.497+x)))
                anchorE.children.append(modelE)
                anchor.children.append(model)
                
                // Add the horizontal plane anchor to the scene
                uiView.scene.anchors.append(anchor)
                uiView.scene.anchors.append(anchorE)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                    uiView.scene.removeAnchor(anchorE)
                }
            }
        }
    }
}


