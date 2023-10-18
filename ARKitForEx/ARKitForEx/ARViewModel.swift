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
                                                          isMetallic: true),
                                 mesh: .box,
                                 size: 0.1,
                                 planes: .horizontal,
                                 classification: .floor)
    
    var newColor: UIColor = .white
    var isMetallic: Bool = true
    var roughness = Float(0)
    
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
    
    // Изменение материала ar model
    func setMaterial(color: UIColor? = nil,
                     metallic: Bool? = nil,
                     roughness: Float? = nil)  {

        if let color {
            newColor = color
        }

        if let metallic {
            if metallic {
                isMetallic = true
            } else {
                isMetallic = false
            }
        }
        arModel.material = SimpleMaterial(color: newColor, roughness: .float(roughness ?? 0), isMetallic: isMetallic)

    }
    
    // Изменение фигуры ar model
    func setMesh(mesh: MeshEntity)  {
        arModel.mesh = mesh
    }
    
    // Изменение фигуры ar model
    func setSize(value: Double)  {
        arModel.size = Float(value) / 100
    }
}

