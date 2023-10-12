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
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
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
                    self.scene.anchors.removeAll()
                case .addTiger:
                    self.addTigerFromFile()
                }
            }
            .store(in: &cancellable)
    }
    
    // Установка конфигураций юзера - его местоположения, положения лица и тела
    func configExamples() {
        // Отслеживает устройство относительно его окружения
        let config = ARWorldTrackingConfiguration()
        session.run(config)
        
        // Поддерживается не во всех регионах, отслеживает w.r.t. глобальные координаты
        let geoTrack = ARGeoTrackingConfiguration()
        
        // Отслеживает лица в сцене
        let faceTRack = ARFaceTrackingConfiguration()
        
        // Отслеживает тело в сцене
        let bodyTrack = ARBodyTrackingConfiguration()
    }
    
    func addTigerFromFile() {
        // Загрузить объект из usdz
        let tiger = try? Entity.load(named: "tiger.rcproject 15-51-26-195.reality")
                
        // Добавляем объект к якорю, чтобы он был помещен в сцену
        let anchor = AnchorEntity(.image(group: "AR",
                                         name: "IMG_3755"))
        
        if let tiger {
            anchor.addChild(tiger)
        }
        
        scene.addAnchor(anchor)

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
            scene.addAnchor(anchor)
        }
    }
}
