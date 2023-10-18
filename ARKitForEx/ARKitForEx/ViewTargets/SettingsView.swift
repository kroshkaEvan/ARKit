//
//  SettingsView.swift
//  ARKitForEx
//
//  Created by IvanDev on 18.10.23.
//

import SwiftUI
import ARKit
import RealityKit

struct SettingsView: View {
    
    @StateObject var arViewModel: ARViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    init(arViewModel: ARViewModel) {
        _arViewModel = StateObject(wrappedValue: arViewModel)
        _color = State(initialValue: Color(arViewModel.newColor))
    }
    
    @State var color = Color.white
    @State var metallic = "Metallic"
    @State var isBox = "Box"
    @State var alignment = "Horizontal"
    @State var classification = "Floor"
    @State var size: Double = 10

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Material")) {
                    ColorPicker("Choose your color",
                                selection: $color)
                    Picker("isMetallic",
                           selection: $metallic) {
                        ForEach(["Metallic", "No Metallic"],
                                id: \.self) { system in
                            Text(String(system)).tag(String(system))
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("Mesh")) {
                    Picker("Geometry",
                           selection: $isBox) {
                        ForEach(["Box", "Sphere"],
                                id: \.self) { system in
                            Text(String(system)).tag(String(system))
                        }
                    }
                    Text("Selected size value: \(size)")
                    Slider(value: $size, in: 0...100)
                        .padding()
                }
                
                Section(header: Text("Anchoring component")) {
                    Picker("Alignment",
                           selection: $alignment) {
                        ForEach(["Horizontal", "Vertical"],
                                id: \.self) { system in
                            Text(String(system)).tag(String(system))
                        }
                    }
                    Picker("Classification",
                           selection: $classification) {
                        ForEach(["Wall", "Floor", "Ceiling", "Table", "Seat"],
                                id: \.self) { system in
                            Text(String(system)).tag(String(system))
                        }
                    }.pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("Settings ar view")
            .navigationBarItems(leading: cancelButton)
        }
    }
    
    private var cancelButton: some View {
        Button {
            if metallic == "Metallic" {
                arViewModel.setMaterial(metallic: true)
            } else {
                arViewModel.setMaterial(metallic: false)
            }
            
            arViewModel.setMaterial(color: UIColor(color))
            
            if isBox == "Box" {
                arViewModel.setMesh(mesh: .box)
            } else {
                arViewModel.setMesh(mesh: .sphere)
            }
            
            arViewModel.setSize(value: size)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Set custom view")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(arViewModel: ARViewModel())
    }
}
