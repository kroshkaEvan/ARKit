//
//  CustomARViewRepresentable.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeUIView(context: Context) -> some CustomARView {
        return CustomARView()
    }
}
