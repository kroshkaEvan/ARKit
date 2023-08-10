//
//  ARManager.swift
//  ARKitForEx
//
//  Created by IvanDev on 10.08.23.
//

import Combine

class ARManager {
    static let shared = ARManager()
    
    private init() {
    }
    
    // На что будем подписываться
    var actionStream = PassthroughSubject<ARAction, Never>()
    
    
}
