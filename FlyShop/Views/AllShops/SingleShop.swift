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
    
    @State private var slider: Double = 0
    
    let shopModel: ShopListViewModel
    
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            
            VStack( spacing: 20 ) {
                
                ZStack {
                    Image("singleShopFilter" )
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/10)
                    
                    VStack {
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
                                .background( Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                .cornerRadius(20)
                            
                            Text( "Shoes" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                .cornerRadius(20)
                            
                            Text( "Accessories" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                                .cornerRadius(20)
                        }
                        
                        HStack {
                            Text( "Your size" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 6)
                                .padding([.trailing, .leading], 12)
                                .background(Color.blue)
                                .cornerRadius(20)
                            
                            Text( "+" )
                                .font( .custom("Montserrat-Italic", size: 20))
                                .foregroundColor(Color.white)
                                .padding([.leading, .trailing], 12)
                                .padding([.top, .bottom], 6)
                                .background(Color.blue)
                                .cornerRadius(30)
                            
                            Spacer()
                                                        
                            Slider(value: self.$slider, in: 0...800000, step: 500)
                            .accentColor(Color.red)
                                .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        }
                        
                        
                    }.padding([.leading, .trailing])
                }
                WaterfallGrid(self.shopModel.products) { product in
                    SingleProduct(product: product)
                }
                
                
            }
        }.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
    }
    
}
