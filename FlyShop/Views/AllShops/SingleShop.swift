//
//  SingleShop.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SwiftUIX
import WaterfallGrid

struct SingleShop: View {
    
    @ObservedObject var shopVM = ShopViewModel()
    let shopModel: ShopListViewModel
    let category = ["Հագուստ", "Կոշիկ", "Աքսեսուարներ"]
    
    init(shopModel: ShopListViewModel) {
        self.shopModel = shopModel
        self.shopVM.shopName = self.shopModel.name
        self.shopVM.getProducts()
    }
    
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            VStack( spacing: 0) {
                
                ZStack {
                    Image("singleShopFilter" )
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/9)
                    
                    VStack {
                        HStack {
                            
                            TextDesign(text: shopModel.name, size: 13, font: "Montserrat-ExtraLight", color: Color.white)
                            
                            Spacer()
                            
                            
                            ForEach( self.category, id: \.self ) { currentCategory in
                                TextDesign(text: currentCategory, size: 11, font: "Montserrat-ExtraLight", color: Color.white)
                                    .lineLimit(1)
                                    .padding([.top, .bottom], 8)
                                    .padding([.horizontal], 12)
                                    .background( self.shopVM.category == currentCategory ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        if self.shopVM.category == currentCategory {
                                            self.shopVM.category = ""
                                        } else {
                                            self.shopVM.category = currentCategory
                                        }
                                    }
                            }
                        }
                        
                        HStack {
                            
                            TextDesign(text: self.shopVM.price == 0 ? "Գինը" : String(format: "%.0f", self.shopVM.price), size: 13, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 6)
                                .padding([.trailing, .leading], 12)
                                .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                                .cornerRadius(20)
                            
                            
                            Spacer()
                            
                            Slider(value: self.$shopVM.price, in: 0...400000, step: 1000)
                                .accentColor(Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                                .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        }
                    }.padding([.leading, .trailing])
                }.zIndex(1)
                
                
                if #available(iOS 14.0, *) {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    AnyView( ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(self.shopVM.filter(), id: \.id ) { product in
                                SingleProduct(product: product)
                            }
                        }.zIndex(0)
                    } )
                    
                } else {

                    WaterfallGrid(self.shopVM.filter()) { product in
                        SingleProduct(product: product)
                    }.id(UUID())
                }
            }
            
            if self.shopVM.loading {
                Loading()
            }
        }.navigationBarTitle(Text( "FlyShop"), displayMode: .inline)
        //.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
    }
}
