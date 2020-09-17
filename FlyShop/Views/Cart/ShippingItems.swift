//
//  ShippingItems.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/21/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShippingItems: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        List {
            ForEach( self.cartVM.shippingProductsList.products.filter{ $0.shipped == false }, id: \.productId ) { product in
                HStack {
                    
                    WebImage(url: URL(string: product.image[0]))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)
                    
                    VStack {
                        
                        Text( product.productName )
                            .font(.system(size: 17))
                        
                        
                        HStack {
                            Spacer()
                            Text( "Չափս: \(product.size)" )
                                .foregroundColor(Color.green)
                                .padding(.trailing, 8)
                        }
                        
                        HStack {
                            Spacer()
                            Text( "Գին: \(product.productPrice)" )
                                .foregroundColor(Color.green)
                                .padding(.trailing, 8)
                        }

                    }
                    
                }.background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.gray, radius: 8, x: 8, y: 8)
            }
        }
        .navigationBarTitle(Text( "Ճանապարհին" ), displayMode: .inline)
    }
}

struct ShippingItems_Previews: PreviewProvider {
    static var previews: some View {
        ShippingItems()
    }
}
