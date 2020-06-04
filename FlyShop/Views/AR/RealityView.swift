//
//  RealityView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct RealityView: View {
    var body: some View {
        RealityIntegratedViewController()
        .navigationBarTitle(Text(""), displayMode: .inline)
        
    }
}

struct RealityView_Previews: PreviewProvider {
    static var previews: some View {
        RealityView()
    }
}
