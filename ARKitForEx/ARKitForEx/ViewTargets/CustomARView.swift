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
    
    // Для хранения отменияемыз подписок
    private var cancellable: Set<AnyCancellable> = []
    
    // Подписка на действия
    func subcribeActionStream() {
        ARManager.shared
            .actionStream
            .sink { action in
                switch action {
                case .placeBox(color: let color):
                    self.placeBox(color: color)
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
    
    func anchorExamples() {
        // Прикрепляем якоря к определенным координатам в системе координат, ориентированной на iPhone
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        // Прикрепляем якоря к обнаруженным плоскостям (это лучше всего работает на устройствах с датчиком LIDAR)
        let planeAnchor = AnchorEntity(.plane([.vertical, .horizontal],
                                              classification: [.wall, .floor, .ceiling],
                                              minimumBounds: [1.0, 1.0]))
        
        // Прикрепляем якоря к отслеживаемым частям тела
        let faceAnchor = AnchorEntity(.face) // к лицу
        
        // Прикрепляем к отслеживаемым изображениям привязки, такие как маркеры или визуальные коды.
        let imageAnchor = AnchorEntity(.image(group: "group",
                                              name: "name"))
        
        // Добавляем якорь в сцену
        scene.addAnchor(coordinateAnchor)
    }
    
    func addTigerFromFile() {
        // Загрузить объект из usdz
        let tiger = try? Entity.load(named: "tiger.rcproject 15-51-26-195.reality")
                
        // Добавляем объект к якорю, чтобы он был помещен в сцену
        let anchor = AnchorEntity()

        if let tiger {
            anchor.addChild(tiger)
        }
        
        scene.addAnchor(anchor)

    }
    
    // Резервация места под синий куб
    func placeBox(color: Color) {
        let box = MeshResource.generateBox(size: 0.5)

        let material = SimpleMaterial(color: UIColor(color),
                                      isMetallic: true)
        
        let entity = ModelEntity(mesh: box,
                                 materials: [material])
        let anchor = AnchorEntity(.plane([.horizontal],
                                         classification: [.floor],
                                         minimumBounds: [1.0, 1.0]))
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
}
