//
//  ContentView.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var colors: [Color] = [
        .cyan,
        .red,
        .blue
    ]
    
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40,
                                       height: 40,
                                       alignment: .center)
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(10)
                        }
                        
                        ForEach(colors, id: \.self) { color in
                            Button {
                                ARManager.shared.actionStream.send(.placeBox(color: color))
                            } label: {
                                color
                                    .frame(width: 40,
                                           height: 40,
                                           alignment: .center)
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
