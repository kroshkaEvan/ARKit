//
//  CustomARViewRepresentable.swift
//  FaceStarWars
//
//  Created by IvanDev on 19.10.23.
//

import SwiftUI
import RealityKit

struct CustomARViewRepresentable: UIViewRepresentable {
    
    let arView = CustomARView()
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    func makeUIView(context: Context) -> ARView {
        return arView.arView
    }
}
