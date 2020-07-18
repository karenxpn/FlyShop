//
//  ARContentVIew.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/1/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ARContentView: View {
    
    let selectedModelName: String
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfiremedForPlacement: Model?
    
    var models: [Model] = {
        // Dynamically get our model filenames
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availableModels: [Model] = []
        
        for filename in files where filename.hasSuffix( "usdz" ) {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            
            let model = Model(modelName: modelName)

            availableModels.append(model)
        }
        
        return availableModels
    }()
    
    var body: some View {
        
        ZStack( alignment: .bottom ) {
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfiremedForPlacement)
            
            if self.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfiremedForPlacement: self.$modelConfiremedForPlacement)
            } else {
                ModelPickerView(passedModel: self.selectedModelName, isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: models)
            }
            
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmedForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        let arView = CustomARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = self.modelConfirmedForPlacement {
            
            if let modelEntity = model.modelEntity {
                let anchorEntity = AnchorEntity(plane: .any )
                
                anchorEntity.addChild(modelEntity)
                uiView.scene.addAnchor(anchorEntity)
            } else {
                print("Unable to load modelEntity for - \(model.modelName)")
            }
                        
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
    }
}

class CustomARView: ARView {
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true)
        
        self.setupArView()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupArView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
    }
}

extension CustomARView: FEDelegate {
    func toTrackingState() {
        print( "tracking" )
    }
    
    func toInitializingState() {
        print("initializing" )
    }
}


struct ModelPickerView: View {
    
    let passedModel: String
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    var models: [Model]
    
    var body: some View {
        ScrollView( .horizontal ) {
            HStack ( spacing: 20 ) {
                ForEach( 0..<self.models.filter{$0.modelName == passedModel}.count) { index in
                    Button(action: {
                        self.isPlacementEnabled = true
                        self.selectedModel = self.models[index]
                    }, label: {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .cornerRadius(12)
                    }).buttonStyle(PlainButtonStyle())
                }
            }
        }.padding(20)
        .background(Color.black.opacity(0.5))
    }
}

struct PlacementButtonsView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfiremedForPlacement: Model?
    
    var body: some View {
        
        HStack {
            // cancel button
            Button(action: {
                self.isPlacementEnabled = false
                self.selectedModel = nil
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
            
            // confirm button
            Button(action: {
                self.modelConfiremedForPlacement = self.selectedModel
                self.isPlacementEnabled = false
                self.selectedModel = nil
            }, label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })

        }

    }
}


struct ARContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        ARContentView(selectedModelName: "Gotiner")
    }
}
