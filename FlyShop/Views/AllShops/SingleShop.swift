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
    
    @ObservedObject var allShopsFilterVM = AllShopsFilter()
    @EnvironmentObject var shopVM: ShopViewModel
    
    let shopModel: ShopListViewModel
    
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
                            
                            TextDesign(text: "Հագուստ", size: 11, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Հագուստ" ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                .cornerRadius(20)
                                .onTapGesture {
                                    if self.allShopsFilterVM.category == "Հագուստ" {
                                        self.allShopsFilterVM.category = ""
                                    } else {
                                        self.allShopsFilterVM.category = "Հագուստ"
                                    }
                            }
                            
                            TextDesign(text: "Կոշիկ", size: 11, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Կոշիկ" ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                .cornerRadius(20)
                                .onTapGesture {
                                    if self.allShopsFilterVM.category == "Կոշիկ" {
                                        self.allShopsFilterVM.category = ""
                                    } else {
                                        self.allShopsFilterVM.category = "Կոշիկ"
                                    }
                            }
                            
                            TextDesign(text: "Աքսեսուարներ", size: 11, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Աքսեսուարներ" ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                            .lineLimit(1)
                                .cornerRadius(20)
                                .onTapGesture {
                                    if self.allShopsFilterVM.category == "Աքսեսուարներ" {
                                        self.allShopsFilterVM.category = ""
                                    } else {
                                        self.allShopsFilterVM.category = "Աքսեսուարներ"
                                    }
                            }
                        }
                        
                        HStack {
                            
                            TextDesign(text: self.allShopsFilterVM.price == 0 ? "Գինը" : String(format: "%.0f", self.allShopsFilterVM.price), size: 13, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 6)
                                .padding([.trailing, .leading], 12)
                                .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                                .cornerRadius(20)
                            
                            
                            Spacer()
                            
                            Slider(value: self.$allShopsFilterVM.price, in: 0...400000, step: 1000)
                                .accentColor(Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                                .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        }
                        
                        
                    }.padding([.leading, .trailing])
                }
                
                WaterfallGrid(self.allShopsFilterVM.filter(products: self.shopVM.shopProducts)) { product in
                    SingleProduct(product: product)
                    
                }
            }
        }.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
    }
}
