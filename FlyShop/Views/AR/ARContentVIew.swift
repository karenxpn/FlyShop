//
//  ARContentVIew.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/1/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct ARContentVIew: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: RealityView()) {
                Text("Enter AR")
            }
        }
    }
}

struct ARContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        ARContentVIew()
    }
}
