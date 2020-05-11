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
    
    let shopModel: ShopListViewModel
    
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            
            VStack( spacing: 20 ) {
                
                ZStack {
                    Image("singleShopFilter" )
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/9)
                    
                    VStack( spacing: 5) {
                        HStack {
                            Text( shopModel.name )
                                .font(.custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Text( "Clothes" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Clothes" ? Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)) : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    if self.allShopsFilterVM.category == "Clothes" {
                                        self.allShopsFilterVM.category = ""
                                    } else {
                                        self.allShopsFilterVM.category = "Clothes"
                                    }
                            }
                            
                            Text( "Shoes" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Shoes" ? Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)) : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.allShopsFilterVM.category = "Shoes"
                            }
                            
                            Text( "Accessories" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.allShopsFilterVM.category == "Accessories" ? Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)) : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.allShopsFilterVM.category = "Accessories"
                            }
                        }
                        
                        HStack {
                            Text( self.allShopsFilterVM.price == 0 ? "Price" : String(format: "%.0f", self.allShopsFilterVM.price))
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 6)
                                .padding([.trailing, .leading], 12)
                                .background(Color.blue)
                                .cornerRadius(20)
                            

                            Spacer()
                            
                            Slider(value: self.$allShopsFilterVM.price, in: 0...400000, step: 100)
                                .accentColor(Color.red)
                                .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        }
                        
                        
                    }.padding([.leading, .trailing])
                }
                WaterfallGrid(self.allShopsFilterVM.filter(model: self.shopModel)) { product in
                    SingleProduct(product: product)
                }
                
            }
        }.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)

    }
    
}
