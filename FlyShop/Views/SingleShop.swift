//
//  SingleShop.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct SingleShop: View {
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            VStack {
                Spacer()
                Text("hjhkjhkjhkjhlkjhkjlhkjlhkjhkjlhkjhlkjhkljhkjhlkjhkljhkjlhkjhjkhjkhklhk")
            }.navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }
    }
}

struct SingleShop_Previews: PreviewProvider {
    static var previews: some View {
        SingleShop()
    }
}
