//
//  ARAction.swift
//  ARKitForEx
//
//  Created by IvanDev on 10.08.23.
//

import SwiftUI
import ARKit
import RealityKit

enum ARAction{
    case placeEntity(model: ARDefaultModel)
    case removeAllAnchors
    case openSettings
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
