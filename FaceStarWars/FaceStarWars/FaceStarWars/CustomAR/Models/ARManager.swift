//
//  ARManager.swift
//  FaceStarWars
//
//  Created by IvanDev on 19.10.23.
//

import Combine
import ARKit
import RealityKit
import SwiftUI

class ARManager {
    static let shared = ARManager()
    
    private init() {
    }
    
    // На что будем подписываться
    var actionStream = PassthroughSubject<ARAction, Never>()
    
}

enum ARAction{
    case placeEntity(model: ARDefaultModel)
    case removeAllAnchors
    case addFootballStadium
    case addMandoModel
}

enum MeshEntity {
    case box
    case sphere
    case text(_ string: String)
}

struct ARDefaultModel {
    var material: SimpleMaterial
    var mesh: MeshEntity
    var size: Float
    var planes: AnchoringComponent.Target.Alignment
    var classification: AnchoringComponent.Target.Classification
}
