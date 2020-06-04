//
//  RealityViewController.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//


import Foundation
import UIKit
import RealityKit


class RealityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a background color a placerholder
        view.backgroundColor = .white
        //Comment out below this when previewing!
        // Create a new ARView
        let arView = ARView(frame: UIScreen.main.bounds)
        // Add the ARView to the view
        view.addSubview(arView)
        // Load the "Box" scene from the "Experience" Reality File
        
        let scene = UserDefaults.standard.string(forKey: "AR")
        if scene == "Pull Bear Grey Ash Sneakers" {
            if let boxScene = try? Experience.loadScene(){
                arView.scene.anchors.append(boxScene)
            }
        } else if scene == "PUMA Suede Classic velours Homme Brun" {
            if let boxScene = try? Experience.loadPuma(){
                arView.scene.anchors.append(boxScene)
            }
        }

        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))

        textView.text = "Մոտեցրեք ապա հեռվացրեք մակերեսի վրա"
        textView.textAlignment = .center
        textView.textColor = .black
        
        view.addSubview(textView)
    }
}
