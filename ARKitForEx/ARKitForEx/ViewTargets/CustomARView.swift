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
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        placeCyanBox()
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
    
    func entityExamples() {
        // Загрузить объект из usdz
        let objectU = try? Entity.load(named: "usdzFileName")
        
        // Загрузить объект из файла реальности
        let objectR = try? Entity.load(named: "realityFileName")
        
        // Генерируем сущность с кодом
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        // Добавляем объект к якорю, чтобы он был помещен в сцену
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    // Резервация места под синий куб
    func placeCyanBox() {
        let box = MeshResource.generateBox(size: 0.2)
        let sphere = MeshResource.generateSphere(radius: 0.2)

        let material = SimpleMaterial(color: .orange,
                                      isMetallic: true)
        
        let entity = ModelEntity(mesh: sphere,
                                 materials: [material])
        let anchor = AnchorEntity(.plane([.horizontal],
                                         classification: [.floor],
                                         minimumBounds: [1.0, 1.0]))
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
}
