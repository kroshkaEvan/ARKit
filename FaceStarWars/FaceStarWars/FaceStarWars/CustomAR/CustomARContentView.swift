//
//  CustomARContentView.swift
//  FaceStarWars
//
//  Created by IvanDev on 19.10.23.
//

import SwiftUI
import Metal

struct CustomARContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var arViewModel: CustomARViewModel
    
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
                        CustomARButton(action: arViewModel.placeARFootball,
                                       imageName: "sportscourt")
                        FaceARButton(action: arViewModel.placeMandoModel,
                                       imageName: "Mando")
                        CustomARButton(action: arViewModel.placeGroguObject,
                                       imageName: "cup.and.saucer.fill")
                        CustomARButton(action: backToInitView,
                                       imageName: "arrow.uturn.backward")
                    }
                    .padding()
                }
            }
            .fullScreenCover(isPresented: $shouldShowSettings) {
                SettingsContentView(arViewModel: arViewModel)
            }
    }
    
    func backToInitView() {
        presentationMode.wrappedValue.dismiss()
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
                .frame(width: 70,
                       height: 70,
                       alignment: .center)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
        }
    }
}
