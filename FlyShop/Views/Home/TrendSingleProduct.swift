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
                        
                        
                        HStack {
                            
                            VStack {
                                
                                Text( self.homeVM.foundProduct[0].name )
                                    .foregroundColor(Color.gray)
                                    .font(.custom("Montserrat-Light", size: 18))
                                
                                Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                                
                                WebImage(url: self.image == "" ? URL(string: self.homeVM.foundProduct[0].image[0]) : URL(string: image))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/3 )
                                    .cornerRadius(15)
                            }
                            
                            Spacer()
                            
                            VStack( spacing: 20) {
                                
                                Text( "Price" )
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat-Light", size: 28))
                                
                                Text( self.self.homeVM.foundProduct[0].sale == 0 ? self.homeVM.foundProduct[0].price : self.homeVM.foundProduct[0].priceWithSale )
                                    .foregroundColor(self.self.homeVM.foundProduct[0].sale == 0 ? Color.white : Color.red)
                                    .font(.custom("Montserrat-Light", size: 28))
                                
                            }.padding()
                        }
                        
                        HStack {
                            
                            VStack {
                                
                                Text( "Description" )
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat-Light", size: 28))
                                    .frame( width: UIScreen.main.bounds.size.width/2)
                                    .padding([.top, .bottom])
                                
                                Text( self.homeVM.foundProduct[0].description )
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat-Light", size: 28))
                                    .frame( width: UIScreen.main.bounds.size.width/2)
                                    .padding(.bottom)
                                
                                
                                Text( self.size )
                                    .frame( width: UIScreen.main.bounds.size.width/2 - 40)
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat-Light", size: 26))
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
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 50)
                                                .fill(Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 0.3)))
                                    )
                                }.padding(.top, 12)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack {
                                ForEach(self.homeVM.foundProduct[0].image, id: \.self) { image in
                                    WebImage(url: URL(string: image))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/5 )
                                        .cornerRadius(15)
                                    .onTapGesture {
                                            self.image = image
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        
                        
                    }.padding()
                }
            }.alert(isPresented: self.$showAlert, content: {
                if self.activeAlert == .error {
                    return Alert(title: Text( "Error"), message: Text( "Select Size"), dismissButton: .default(Text( "OK")))
                } else {
                    return Alert(title: Text( "Congratulations" ), message: Text( "This item has been added to cart" ), dismissButton: .default(Text( "OK")))
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
