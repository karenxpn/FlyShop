//
//  AllShopGridCell.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct AllShopGridCell : View {
    
    @EnvironmentObject var shopVM: ShopViewModel
    @State private var show: Bool = false
    var shopModel: ShopListViewModel

    var body: some View  {
        
        VStack {
            
            NavigationLink(destination: SingleShop(shopModel: self.shopModel).environmentObject(self.shopVM), isActive: self.$show) {
                EmptyView()
            }
            
            Button(action: {
                self.shopVM.shopName = self.shopModel.name
                self.shopVM.getProducts()
                self.show.toggle()
            }) {
                VStack {
                    
                    TextDesign(text: shopModel.name, size: 14, font: "Montserrat-ExtraLight", color: Color.gray)
                    
                    WebImage(url: URL(string: shopModel.image ))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width/2 - 20, height: UIScreen.main.bounds.size.height/6 )
                        .cornerRadius(10)
                    
                    
                }.padding([.top, .bottom], 12)
                    .padding([.trailing, .leading], 6)
                    .background(Color.white)
                    .cornerRadius(15)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

