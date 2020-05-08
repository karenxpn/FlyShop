//
//  SingleProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleProduct: View {
    
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
                    
                    Text( product.price)
                        .foregroundColor(Color.gray)
                        .font(.custom("Montserrat-Italic", size: 15))
                        .padding(.trailing)
                        .offset(x: UIScreen.main.bounds.size.width/6.5)
                    
                }
            }
            
        }.padding([.top, .bottom], 6)
            .padding([.trailing, .leading], 10)
            .background(Color.white)
            .cornerRadius(15)
    }
}

//struct SingleProduct_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleProduct()
//    }
//}
