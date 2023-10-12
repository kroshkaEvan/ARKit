//
//  ARManager.swift
//  ARKitForEx
//
//  Created by IvanDev on 10.08.23.
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
