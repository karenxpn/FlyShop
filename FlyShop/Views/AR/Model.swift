//
//  Model.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/18/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        //let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(contentsOf: URL(string: modelName)!, withName: "ARProducts")
            .sink(receiveCompletion: { (loadCompletion) in
                // handle our error
                print("Unable to load modelEntity for modelName: \(self.modelName)")
            }, receiveValue: { (modelEntity) in
                // get our entity
                self.modelEntity = modelEntity
                print("Successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
