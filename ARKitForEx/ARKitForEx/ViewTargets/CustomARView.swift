//
//  CustomARView.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

class CustomARView: ARView {
    
    @StateObject var viewModel: CustomARViewModel = CustomARViewModel()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        viewModel.subcribeActionStream(arView: self)
    }

}
