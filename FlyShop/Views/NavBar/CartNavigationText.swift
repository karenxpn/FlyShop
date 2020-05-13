//
//  CartNavigationText.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct CartNavigationText: View {
    var body: some View {
        Text("My Cart")
            .foregroundColor(Color.white)
            .font(.custom("McLaren-Regular", size: 18))
    }
}

struct CartNavigationText_Previews: PreviewProvider {
    static var previews: some View {
        CartNavigationText()
    }
}
