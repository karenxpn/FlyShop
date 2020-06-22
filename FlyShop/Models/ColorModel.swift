//
//  ColorModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/23/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

class ColorModel {
    
    let colors = [
        "blue" : Color.blue,
        "green" : Color.green,
        "gray" : Color.gray
    ]
    
    func getColorImages( color: String, obj: [ProductColorImage] ) -> [String] {
        for item in obj {
            if item.color == color {
                return item.images
            }
        }
        
        return [String]()
    }
    
    func getColors(color: String) -> Color {
        return colors[color] ?? Color.white
    }
}
