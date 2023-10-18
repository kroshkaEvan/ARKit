//
//  CustomARViewRepresentable.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI
import RealityKit

struct CustomARViewRepresentable: UIViewRepresentable {
    
    let viewModel = CustomARViewModel()
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    func makeUIView(context: Context) -> ARView {
        return viewModel.arView
    }
}
