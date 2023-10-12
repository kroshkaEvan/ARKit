//
//  ARKitForExApp.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI

@main
struct ARKitForExApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(arViewModel: ARViewModel())
        }
    }
}
