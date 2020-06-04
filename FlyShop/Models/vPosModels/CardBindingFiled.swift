//
//  CardBindingFiled.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct CardBindingFiled: Decodable {
    var CardPan: String
    var ExpDate: String
    var IsAvtive: Bool
    var CardHolderID: String
}
