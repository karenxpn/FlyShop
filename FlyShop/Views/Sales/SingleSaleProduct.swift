//
//  SingleSaleProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleSaleProduct: View {
    
    let product: ProductViewModel
    
    var body: some View {
        
        NavigationLink(destination: SelectedProduct(product: product) ) {
            
            VStack {
                
                ZStack {
                    
                    VStack {
                        Text( product.name )
                            .foregroundColor(Color.gray)
                            .font(.custom("Montserrat-Light", size: 14))
                        
                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        WebImage(url: URL(string: product.image[0]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                            .cornerRadius(10)
                        
                        Text( product.priceWithSale )
                            .foregroundColor(Color.red)
                            .font(.custom("Montserrat-Italic", size: 15))
                            .padding(.trailing)
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                    }
                    
                    
                    Image("saleLabel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .offset(x: UIScreen.main.bounds.size.width/6.5,
                                y: -UIScreen.main.bounds.size.height/12.5)
                    
                    Text( "\(product.sale)%")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .rotationEffect(.degrees(40))
                        .offset(x: UIScreen.main.bounds.size.width/5.5,
                                y: -UIScreen.main.bounds.size.height/11.5)
                    
                }
                
            }.padding([.top, .bottom], 6)
                .padding([.trailing, .leading], 10)
                .background(Color.white)
                .cornerRadius(15)
        }.buttonStyle(PlainButtonStyle())
    }
}
