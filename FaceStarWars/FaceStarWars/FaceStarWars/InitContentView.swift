//
//  InitContentView.swift
//  FaceStarWars
//
//  Created by IvanDev on 19.10.23.
//

import SwiftUI
import ARKit
import RealityKit

struct InitContentView: View {
    
    @State var shouldShowFaceAR = false

    @State var shouldShowCustomAR = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:
                                        Gradient(colors: [Color.pink,
                                                          Color.blue]),
                                       startPoint: .topTrailing,
                                       endPoint: .bottomLeading)

            VStack {
                Button {
                    openFaceARView()
                } label: {
                    Text("Tap me - open FaceARView")
                        .font(.system(size: 30,
                                      weight: .bold,
                                      design: .monospaced))
                }
                .background(
                    LinearGradient(gradient:
                                    Gradient(colors: [Color.green,
                                                      Color.gray]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .padding()
                
                Button {
                    openCustomARView()
                } label: {
                    Text("Tap me - open CustomARView")
                        .font(.system(size: 30,
                                      weight: .bold,
                                      design: .monospaced))
                }
                .background(
                    LinearGradient(gradient:
                                    Gradient(colors: [Color.red,
                                                      Color.orange]),
                                   startPoint: .center,
                                   endPoint: .trailing)
                )
                .padding()
            }
            .fullScreenCover(isPresented: $shouldShowFaceAR) {
                FaceARContentView()
            }
            .fullScreenCover(isPresented: $shouldShowCustomAR) {
                CustomARContentView(arViewModel: CustomARViewModel())
            }
        }

        
    }
    
    // Открытие экрана настроек
    func openFaceARView() {
        shouldShowFaceAR.toggle()
    }
    
    // Открытие экрана настроек
    func openCustomARView() {
        shouldShowCustomAR.toggle()
    }
}

struct InitContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitContentView()
    }
}
