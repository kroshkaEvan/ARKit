//
//  CustomARViewModel.swift
//  ARKitForEx
//
//  Created by IvanDev on 12.10.23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

final class CustomARViewModel: ObservableObject {
    
    var arView: ARView = ARView(frame: .zero)
    
    init() {
        subcribeActionStream()
    }
    
    // Для хранения отменияемых подписок
    private var cancellable: Set<AnyCancellable> = []
    
    // Подписка на действия
    func subcribeActionStream() {
        ARManager.shared
            .actionStream
            .sink { action in
                switch action {
                case .placeEntity(model: let model):
                    self.placeEntity(model: model)
                case .removeAllAnchors:
                    self.arView.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellable)
    }
    
    // Резервация места под требуемый предмет
    func placeEntity(model: ARDefaultModel) {
        var entity: ModelEntity?
        
        switch model.mesh {
        case .box:
            let box = MeshResource.generateBox(size: model.size)
            entity = ModelEntity(mesh: box,
                                 materials: [model.material])
        case .sphere:
            let sphere = MeshResource.generateSphere(radius: model.size)
            entity = ModelEntity(mesh: sphere,
                                 materials: [model.material])
        case .text( let text):
            let textEntity = MeshResource.generateText(text)
            entity = ModelEntity(mesh: textEntity,
                                 materials: [model.material])
        }

        let anchor = AnchorEntity(.plane([model.planes],
                                         classification: model.classification,
                                         minimumBounds: [0.1, 0.1]))
        if let entity {
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
        }
    }
}

