//
//  ContentView.swift
//  ARKitForEx
//
//  Created by IvanDev on 9.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var arViewModel: ARViewModel

    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            arViewModel.removeARmodel()
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
                        
                        Button {
                            arViewModel.placeARmodel()
                        } label: {
                            Image(systemName: "plus")
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
                    .padding()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(arViewModel: ARViewModel())
    }
}
