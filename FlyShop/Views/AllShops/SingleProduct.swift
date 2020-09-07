//
//  SingleProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import QuickLookThumbnailing

struct SingleProduct: View {
    
    let product: ProductViewModel
    
    var body: some View {
        NavigationLink(destination: SelectedProduct(product: product)) {
            if product.sale == 0 {
                ZStack {
                    
                    VStack {
                        
                        TextDesign(text: "\(product.brand): \(product.name)", size: 13, font: "Montserrat-ExtraLight", color: Color.gray)
                            .lineLimit(1)
                        
                        
                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        WebImage(url: URL(string: product.images[0]), context: [.imageThumbnailPixelSize : CGSize(width: 250, height: 250)])
                            .placeholder(content: {
                                Rectangle().foregroundColor(.gray)
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                            .cornerRadius(10)
                        
                        TextDesign(text: "\(product.price)դր.", size: 14, font: "Montserrat-ExtraLight", color: self.product.sale == 0 ? Color.gray : Color.red)
                            .padding(.trailing)
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                        
                    }
                }
                .padding([.top, .bottom], 6)
                .padding([.trailing, .leading], 10)
                .background(Color.white)
                .cornerRadius(15)
                
            } else {
                
                ZStack {
                    
                    VStack {
                        
                        TextDesign(text: product.name, size: 13, font: "Montserrat-ExtraLight", color: Color.gray)
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40)
                            .lineLimit(1)
                        
                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        WebImage(url: URL(string: product.images[0]),context: [.imageThumbnailPixelSize : CGSize(width: 250, height: 250)] )
                            .resizable()
                            .placeholder(content: {
                                Rectangle().foregroundColor(.gray)
                            })
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/7 )
                            .cornerRadius(10)
                        
                        TextDesign(text: "\(product.price)դր.", size: 14, font: "Montserrat-ExtraLight", color: Color.red)
                            .padding(.trailing)
                            .offset(x: UIScreen.main.bounds.size.width/6.5)
                    }
                    
                    
                    Image("saleLabel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .offset(x: UIScreen.main.bounds.size.width/6.5,
                                y: UIScreen.main.bounds.size.height == 667.0 ? -UIScreen.main.bounds.size.height/12 : -UIScreen.main.bounds.size.height/12.5)
                    
                    Text( "\(product.sale)%")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .rotationEffect(.degrees(40))
                        .offset(x: UIScreen.main.bounds.size.width/5.5,
                                y: UIScreen.main.bounds.size.height == 667.0 ? -UIScreen.main.bounds.size.height/11 : -UIScreen.main.bounds.size.height/11.5)
                    
                }
                .padding([.top, .bottom], 6)
                .padding([.trailing, .leading], 10)
                .background(Color.white)
                .cornerRadius(15)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}
