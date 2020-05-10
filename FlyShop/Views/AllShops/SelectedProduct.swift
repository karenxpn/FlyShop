//
//  SelectedProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/10/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectedProduct: View {
    
    let product: ProductViewModel
    @State private var showSheet: Bool = false
    @State private var size: String = "Size"
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            ScrollView {
                VStack( spacing: 20) {
                    
                    HStack {
                        
                        VStack {
                            
                            Text( product.name )
                                .foregroundColor(Color.gray)
                                .font(.custom("Montserrat-Light", size: 18))
                            
                            Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                            
                            WebImage(url: URL(string: product.image[0]))
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/4 )
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        VStack( spacing: 20) {
                            
                            Text( "Price" )
                                .foregroundColor(Color.white)
                                .font(.custom("Montserrat-Light", size: 28))
                            
                            Text( product.price )
                                .foregroundColor(Color.white)
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
                            
                            Text( product.description )
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
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack {
                            ForEach(product.image, id: \.self) { image in
                                WebImage(url: URL(string: image))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.size.width/2 - 40, height: UIScreen.main.bounds.size.height/5 )
                                    .cornerRadius(15)
                            }
                        }
                    }
                    
                    
                    ZStack {
                        
                        Circle().fill(Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1))).frame(width: 50, height: 50)
                        
                        
                        Image("plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .cornerRadius(10)
                            .padding()
                    }.onTapGesture {
                        if self.size == "Size" {
                            self.showAlert.toggle()
                        }
                        print( "Fire!!! TODO List" )
                    }
                    
                }.padding()
            }.alert(isPresented: self.$showAlert, content: {
                Alert(title: Text( "Error"), message: Text( "Select Size"), dismissButton: .default(Text( "OK")))
            })
            .sheet(isPresented: self.$showSheet) {
                SizeSheet(sizeList: self.product.size, showSeet: self.$showSheet, selectedSize: self.$size)
            }
        }.navigationBarTitle(Text( "FlyShop"), displayMode: .inline)
    }
}

//struct SelectedProduct_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedProduct()
//    }
//}
