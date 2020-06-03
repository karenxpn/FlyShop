//
//  RealityViewController.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/1/20.
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
        let boxAnchor = try! Experience.loadBox()
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))

        textView.text = "Մոտեցրեք ապա հեռվացրեք մակերեսի վրա"
        textView.textAlignment = .center
        textView.textColor = .black
        
        view.addSubview(textView)
    }
}
