//
//  TrendSingleProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

enum ActiveAlert {
    case error, success
}

struct TrendSingleProduct: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var showSheet: Bool = false
    @State private var size: String = "Size"
    @State private var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .error
    @State private var image: String = ""
    
    
    
    var body: some View {
        ZStack {
            
            AllShopsBackground()
            
            ScrollView {
                if self.homeVM.foundProduct.isEmpty != true {
                    
                    VStack( spacing: 20) {
                        
                        
                        VStack {
                            
                            TextDesign(text: self.homeVM.foundProduct[0].name, size: 18, font: "Montserrat-ExtraLight", color: Color.black)
                                .padding(.top, 12 )
                            
                            
                            Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                            
                            ImageCarouselView(numberOfImages: self.homeVM.foundProduct[0].image.count) {
                                ForEach( self.homeVM.foundProduct[0].image, id: \.self ) { image in
                                    
                                    WebImage(url:URL(string: image) )
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2 )
                                        .cornerRadius(15)
                                    
                                }
                            }.frame(height: UIScreen.main.bounds.size.height/2, alignment: .center)
                        }.background(Color.white)
                            .cornerRadius(15)
                        
                        
                        
                        VStack {
                            
                            TextDesign(text: "Description", size: 27, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding(.bottom)

                            
                            TextDesign(text: self.homeVM.foundProduct[0].description, size: 21, font: "Montserrat-ExtraLight", color: Color.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                                .padding(.horizontal, 8)
                            
                            
                            HStack {
                                TextDesign(text: "Price", size: 27, font: "Montserrat-ExtraLight", color: Color.white)
                                
                                TextDesign(text: self.self.homeVM.foundProduct[0].sale == 0 ? self.homeVM.foundProduct[0].price : self.homeVM.foundProduct[0].priceWithSale, size: 27, font: "Montserrat-ExtraLight", color: self.self.homeVM.foundProduct[0].sale == 0 ? Color.white : Color.red)
                            }
                            
                            
                            TextDesign(text: self.size, size: 25, font: "Montserrat-ExtraLight", color: Color.white)
                                .frame( width: UIScreen.main.bounds.size.width/2 - 60)
                                .background(Color( UIColor( red: 35/255, green: 204/255, blue: 214/255, alpha: 1)))
                                .cornerRadius(10)
                                .multilineTextAlignment(.leading)
                                .padding([.top, .bottom], 6)
                                .onTapGesture {
                                    self.showSheet.toggle()
                            }
                            
                            Button(action: {
                                if self.size == "Size" {
                                    self.activeAlert = .error
                                    self.showAlert.toggle()
                                } else {
                                    let cartModel = CartModel(product: self.homeVM.foundProduct[0], size: self.size)
                                    self.cartVM.cartProducts.append(cartModel)
                                    self.activeAlert = .success
                                    self.showAlert.toggle()
                                }
                            }) {
                                Text("To Cart")
                                    .foregroundColor(Color.white)
                                    .font(.custom("McLaren-Regular", size: 15))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 50)
                                            .fill(Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 0.3)))
                                )
                            }.padding(.top, 12)
                            
                            Spacer()
                            
                        }
                        
                    }
                }
            }.alert(isPresented: self.$showAlert, content: {
                if self.activeAlert == .error {
                    return Alert(title: Text( "Error"), message: Text( "Please Select Size"), dismissButton: .default(Text( "OK")))
                } else {
                    return Alert(title: Text( "Congratulations" ), message: Text( "This product has been added to your cart" ), dismissButton: .default(Text( "OK")))
                }
            })
                .sheet(isPresented: self.$showSheet) {
                    SizeSheet(sizeList: self.self.homeVM.foundProduct[0].size, showSeet: self.$showSheet, selectedSize: self.$size)
            }
        }.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
    }
}

struct TrendSingleProduct_Previews: PreviewProvider {
    static var previews: some View {
        TrendSingleProduct()
    }
}
