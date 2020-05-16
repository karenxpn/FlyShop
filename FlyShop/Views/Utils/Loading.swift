//
//  Loading.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct Loading: View {

    @State var scale: CGFloat = 1

    
    var body: some View {
        
        VStack {
            Image("main")
            .scaleEffect(scale)
            .animateForever(autoreverses: true) { self.scale = 0.5 }

        }
    }
}


struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
