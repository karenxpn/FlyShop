//
//  TextDesign.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/17/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

struct TextDesign: View {
    
    let text: String
    let size: CGFloat
    let font: String
    let color: Color
    
    var body: some View {
        Text( self.text )
            .foregroundColor(self.color)
            .font(.custom(self.font, size: size))
    }
}
