//
//  TabItemModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

struct TabItemModel {
    var image: Image
    var title: String
}

extension TabItemModel {
    static func getTabItems() -> [TabItemModel] {
        [
            TabItemModel(image: Image("allShops"), title: "allShops"),
            TabItemModel(image: Image( "new"), title: "new"),
            TabItemModel(image: Image( "main"), title: "main"),
            TabItemModel(image: Image( "sales"), title: "sales"),
            TabItemModel(image: Image( "cart"), title: "cart")

        ]
    }
}
