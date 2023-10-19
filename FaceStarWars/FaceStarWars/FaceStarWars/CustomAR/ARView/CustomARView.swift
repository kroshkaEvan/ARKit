//
//  CustomARViewModel.swift
//  FaceStarWars
//
//  Created by IvanDev on 19.10.23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

final class CustomARView: ObservableObject {
    
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
                case .addFootballStadium:
                    self.placeFootball()
                case .addMandoModel:
                    self.placeMandoModel()
                case .addGroguObject:
                    self.placeObjectGrogu()
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
    
    // Резервация места под кастомный предмет загружаемый из Experience
    func placeFootball() {
        arView.scene.anchors.removeAll()
        let arAnchor = try! Experience.loadFootball()
        arView.scene.addAnchor(arAnchor)
    }
    
    // Резервация места под кастомный предмет загружаемый из Experience
    func placeMandoModel() {
        arView.scene.anchors.removeAll()
        let arAnchor = try! Experience.loadImageMando()
        arView.scene.addAnchor(arAnchor)
    }
    
    // Резервация места под кастомный предмет загружаемый из Experience
    func placeObjectGrogu() {
        arView.scene.anchors.removeAll()
        let arAnchor = try! Experience.loadObjectGrogu()
        arView.scene.addAnchor(arAnchor)
    }
}
