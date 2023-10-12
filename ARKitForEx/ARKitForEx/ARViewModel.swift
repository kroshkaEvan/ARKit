//
//  ARViewModel.swift
//  ARKitForEx
//
//  Created by IvanDev on 12.10.23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

final class ARViewModel: ObservableObject {
    
    var arModel = ARDefaultModel(material: SimpleMaterial(color: .white,
                                                                     roughness: .float(0),
                                                                     isMetallic: false),
                                            mesh: .box,
                                            size: 0.1,
                                            planes: .horizontal,
                                            classification: .floor)
            
//    init(arModel: ARDefaultModel) {
//        self.arModel = arModel
//    }
        
    init() {
        
    }
    
    // Установка ar model в поле
    func placeARmodel() {
        ARManager.shared.actionStream.send(.placeEntity(model: arModel))
    }
    
    // Удаление всех моделей ar в поле
    func removeARmodel() {
        ARManager.shared.actionStream.send(.removeAllAnchors)
    }
    
    // Открытие экрана настроек
    func openSettings() {
        
    }
    
    // Изменение материала ar model
    func setMaterial(color: SimpleMaterial.BaseColor,
                     metallic: Float,
                     roughness: Float)  {
        var material = SimpleMaterial()
        material.color = color
        material.roughness = .float(0)
        material.metallic = .float(0)
        arModel.material = material
    }
    
    // Изменение фигуры ar model
    func setMesh(mesh: MeshEntity)  {
        arModel.mesh = mesh
    }
}

