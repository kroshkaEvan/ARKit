//
//  ContentView.swift
//  FaceStarWars
//
//  Created by IvanDev on 16.10.23.
//

import SwiftUI
import RealityKit
import ARKit

var arView: ARView!

struct FaceARContentView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var propId: Int = 0
    
    var body: some View {
            ARViewContainer(propId: $propId)
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        FaceARButton(action: {self.propId = 0},
                                       imageName: "Mando")
                        FaceARButton(action: {self.propId = 1},
                                       imageName: "DarthVader")
                        FaceARButton(action: {self.propId = 2},
                                       imageName: "BobaFett")
                        FaceARButton(action: {self.propId = 3},
                                       imageName: "ImpScout")
                        FaceARButton(action: {self.propId = 4},
                                       imageName: "blackImp")
                        FaceARButton(action: {self.propId = 5},
                                       imageName: "simpleImp")
                        FaceARButton(action: {self.propId = 6},
                                       imageName: "blackImp")
                        FaceARButton(action: {self.propId = 7},
                                       imageName: "simpleImp")
                        CustomARButton(action: backToInitView,
                                       imageName: "arrow.uturn.backward")
                    }
                    .padding()
                }
            }
    }
    
    func backToInitView() {
        presentationMode.wrappedValue.dismiss()
    }

    func setProp(id: Int) {
        self.propId = id
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var propId: Int
    
    func makeUIView(context: Context) -> ARView {
        arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        arView.scene.anchors.removeAll()
        
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration, options:[.resetTracking, .removeExistingAnchors])
        
        switch(propId) {
        case 0:
            let arAnchor = try! Experience.loadMando()
            uiView.scene.anchors.append(arAnchor)
            break
        case 1:
            let arAnchor = try! Experience.loadDarthVader()
            uiView.scene.anchors.append(arAnchor)
            break
        case 2:
            let arAnchor = try! Experience.loadBobaFet()
            uiView.scene.anchors.append(arAnchor)
        case 3:
            let arAnchor = try! Experience.loadImperian1()
            uiView.scene.anchors.append(arAnchor)
            break
        case 4:
            let arAnchor = try! Experience.loadImperian2()
            uiView.scene.anchors.append(arAnchor)
            break
        case 5:
            let arAnchor = try! Experience.loadImperian3()
            uiView.scene.anchors.append(arAnchor)
            break
        case 6:
            let arAnchor = try! Experience.loadDarthMoul()
            uiView.scene.anchors.append(arAnchor)
            break
        case 7:
            let arAnchor = try! Experience.loadGrogu()
            uiView.scene.anchors.append(arAnchor)
            break
        default:
            break
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        FaceARContentView()
    }
}
#endif

struct FaceARButton: View {
    var action: () -> Void

    var imageName: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70,
                       height: 70,
                       alignment: .center)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
        }
    }
}
