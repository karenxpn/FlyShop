//
//  CartNavigationView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct CartNavigationView: View {
    var body: some View {
            Image("main")
            .resizable()
            .scaledToFit()
                .frame(width: 50, height: 50)
    }
}

struct CartNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CartNavigationView()
    }
}
