//
//  SingleNewProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleNewProduct: View {
    
    let product: ProductViewModel
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                VStack {
                    Text( product.name )
                        .foregroundColor(Color.gray)
                        .font(.custom("Montserrat-Light", size: 14))
                    
                    Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                    
                    WebImage(url: URL(string: product.image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                        .cornerRadius(10)
                    
                    HStack {
                        Text( product.price)
                            .foregroundColor(Color.gray)
                            .font(.custom("Montserrat-Italic", size: 15))
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                        
                    }
                }
                
                
                Image("newProductStick")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .offset(x: UIScreen.main.bounds.size.width/6.5,
                            y: -UIScreen.main.bounds.size.height/12.5)
            }

        }.padding([.top, .bottom], 6)
            .padding([.trailing, .leading], 10)
            .background(Color.white)
            .cornerRadius(15)
    }
}
