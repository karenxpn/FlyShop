//
//  Shipping.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct Shipping: View {
    var body: some View {
        ZStack {
            AllShopsBackground()
            
            VStack {
                ScrollView {
                    Text("Անվճար առաքում մինչև 24 ժամ:\nՓորձեք ձեր իրերը:\nՎերադարձ տեղում")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                }
            }
        }.navigationBarTitle(Text( "Առաքում" ), displayMode: .inline)    }
}

struct Shipping_Previews: PreviewProvider {
    static var previews: some View {
        Shipping()
    }
}
