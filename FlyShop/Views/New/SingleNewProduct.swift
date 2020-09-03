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
        
        NavigationLink(destination: SelectedProduct(product: product) ) {
            
            VStack {
                
                ZStack {
                    
                    VStack {
                        
                        TextDesign(text: "\(product.brand): \(product.name)" , size: 13, font: "Montserrat-ExtraLight", color: Color.gray)
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40)
                            .lineLimit(1)

                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        WebImage(url: URL(string: product.images[0]), context: [.imageThumbnailPixelSize : CGSize(width: 250, height: 250)])
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                            .cornerRadius(10)
                        
                        TextDesign(text: "\(product.price)դր.", size: 14, font: "Montserrat-ExtraLight", color: product.sale == 0 ? Color.gray : Color.red)
                            .padding(.trailing)
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                    }
                    
                    
                    Image("newProductStick")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .offset(x: UIScreen.main.bounds.size.width/6.5,
                                y: UIScreen.main.bounds.size.height == 667.0 ? -UIScreen.main.bounds.size.height/12 : -UIScreen.main.bounds.size.height/12.5)
                }
                
            }.padding([.top, .bottom], 6)
                .padding([.trailing, .leading], 10)
                .background(Color.white)
                .cornerRadius(15)
        }.buttonStyle(PlainButtonStyle())
    }
}
