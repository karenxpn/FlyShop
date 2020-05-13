//
//  CartItemPreview.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemPreview: View {
    
    let product: CartModel
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    
                    VStack {
                        Text( product.product.name )
                            .foregroundColor(Color.gray)
                            .font(.custom("Montserrat-Light", size: 14))
                        
                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        WebImage(url: URL(string: product.product.image[0]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                            .cornerRadius(10)
                        
                        Text( self.product.product.sale == 0 ? product.product.price : product.product.priceWithSale )
                            .foregroundColor(self.product.product.sale == 0 ? Color.gray : Color.red)
                            .font(.custom("Montserrat-Italic", size: 15))
                            .padding(.trailing)
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                        
                    }
                    
                }.padding([.top, .bottom], 6)
                    .padding([.trailing, .leading], 10)
                    .background(Color.white)
                    .cornerRadius(15)
                
                
                Text( self.product.size )
                    .frame( width: UIScreen.main.bounds.size.width/2 - 40)
                    .foregroundColor(Color.white)
                    .font(.custom("Montserrat-Light", size: 26))
                    .background(Color( UIColor( red: 35/255, green: 204/255, blue: 214/255, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.top, 6)
            }
            
            Image("removeButton")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .offset(x: UIScreen.main.bounds.size.width/5, y: -UIScreen.main.bounds.size.height/8)
                .onTapGesture {
                    self.cartVM.cartProducts = self.cartVM.cartProducts.filter{$0.id != self.product.id}
            }
        }
    }
}

//struct CartItemPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CartItemPreview()
//    }
//}
