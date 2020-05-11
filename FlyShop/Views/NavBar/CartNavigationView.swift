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
        HStack {
            VStack {
                Text( "My Cart" )
                    .foregroundColor(Color.white)
                    .font(.system(size: 16))
                
                Text( "124000" )
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            Image("main")
            .resizable()
            .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }
}

struct CartNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CartNavigationView()
    }
}
