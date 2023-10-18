//
//  ContentView.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var arViewModel: ARViewModel
    
    @State var shouldShowSettings = false

    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        CustomARButton(action: arViewModel.placeARmodel,
                                       imageName: "plus")
                        CustomARButton(action: arViewModel.removeARmodel,
                                       imageName: "trash")
                        CustomARButton(action: openSettings,
                                       imageName: "star.square")
                    }
                    .padding()
                }
            }
            .fullScreenCover(isPresented: $shouldShowSettings) {
                SettingsView(arViewModel: arViewModel)
            }
    }
    
    // Открытие экрана настроек
    func openSettings() {
        shouldShowSettings.toggle()
    }
}

struct CustomARButton: View {
    var action: () -> Void

    var imageName: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40,
                       height: 40,
                       alignment: .center)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
        }
    }
}
