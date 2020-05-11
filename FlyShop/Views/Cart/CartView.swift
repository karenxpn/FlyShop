//
//  CartView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SwiftUIX


struct CartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("lsdkjf")
                Spacer()
            }
            .navigationBarTitleView( CartNavigationView(), displayMode: .inline)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
