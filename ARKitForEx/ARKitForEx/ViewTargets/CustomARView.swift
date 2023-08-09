//
//  CustomARView.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI
import ARKit
import RealityKit

class CustomARView: ARView {
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
}
