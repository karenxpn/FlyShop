//
//  SVGImage.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/3/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Macaw

struct SVGImage: UIViewRepresentable {

    var svgName: String

    func makeUIView(context: Context) -> SVGView {
        let svgView = SVGView()
        svgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)   // otherwise the background is black
        svgView.fileName = self.svgName
        svgView.contentMode = .scaleToFill
        return svgView
    }

    func updateUIView(_ uiView: SVGView, context: Context) {

    }

}
