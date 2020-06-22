//
//  SelectedProduct.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/10/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertX

struct SelectedProduct: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    let product: ProductViewModel
    @State private var showSheet: Bool = false
    @State private var size: String = "Չափս"
    @State private var activeAlert: ActiveAlert = .error
    @State private var activeSheet: ActiveSheet = .brand
    @State private var showAlert: Bool = false
    @State private var expanded: Bool = false
    @State private var color: String = ""
    
    var body: some View {
        
        ZStack {
            
            AllShopsBackground()
            
            ScrollView {
                VStack( spacing: 20) {
                    
                    
                    VStack {
                        
                        TextDesign(text: product.name, size: 17, font: "Montserrat-ExtraLight", color: Color.black)
                            .lineLimit(1)
                            .padding(.top, 12 )
                        
                        Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                        
                        
                        if self.color == "" {
                            ImageCarouselView(numberOfImages: self.product.images.count, expanded: self.expanded) {
                                ForEach( self.product.images, id: \.self ) { image in
                                    
                                    WebImage(url:URL(string: image) )
                                        .resizable()
                                        .aspectRatio(contentMode: self.expanded ? .fit : .fill)
                                        .frame(width: UIScreen.main.bounds.size.width, height: self.expanded ?  UIScreen.main.bounds.size.height/1.5 : UIScreen.main.bounds.size.height/2 )
                                        .cornerRadius(15)
                                        .onTapGesture {
                                            withAnimation {
                                                self.expanded.toggle()
                                            }
                                            
                                    }
                                    
                                }
                            }.frame(height:  self.expanded ? UIScreen.main.bounds.size.height/1.5 : UIScreen.main.bounds.size.height/2, alignment: .center)
                        } else {
                            ImageCarouselView.init(numberOfImages: ColorModel().getColorImages(color: self.color, obj: self.product.colorImage).count, expanded: self.expanded) {
                                ForEach( ColorModel().getColorImages(color: self.color, obj: self.product.colorImage), id: \.self ) { image in
                                    WebImage(url:URL(string: image) )
                                        .resizable()
                                        .aspectRatio(contentMode: self.expanded ? .fit : .fill)
                                        .frame(width: UIScreen.main.bounds.size.width, height: self.expanded ?  UIScreen.main.bounds.size.height/1.5 : UIScreen.main.bounds.size.height/2 )
                                        .cornerRadius(15)
                                    
                                }
                            }.frame(height:  self.expanded ? UIScreen.main.bounds.size.height/1.5 : UIScreen.main.bounds.size.height/2, alignment: .center)
                        }
                        
                        
                    }.background(Color.white)
                        .cornerRadius(15)
                    
                    
                    VStack {
                        
                        HStack {
                            
                            ForEach( self.product.colorImage, id: \.color ) { item in
                                Circle().stroke(Color.white, lineWidth: self.color == item.color ? 3 : 0)
                                    .overlay(Circle().fill( ColorModel().getColors(color: item.color)) )
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        self.color = item.color
                                        withAnimation {
                                            self.expanded = true
                                            
                                        }
                                        
                                }
                            }
                            
                            if product.ar {
                                TextDesign(text: "Դիտեք AR-ը", size: 18, font: "Montserrat-ExtraLight", color: Color.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal)
                                    .background(Color.green)
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        UserDefaults.standard.set(self.product.name, forKey: "AR")
                                        self.activeSheet = .arView
                                        self.showSheet = true
                                }
                            }
                        }
                        
                        TextDesign(text: "Նկարագրություն", size: 27, font: "Montserrat-ExtraLight", color: Color.white)
                            .padding(.bottom)
                        
                        
                        TextDesign(text: product.description, size: 21, font: "Montserrat-ExtraLight", color: Color.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                            .padding(.horizontal, 8)
                        
                        
                        HStack {
                            TextDesign(text: "Գինը", size: 27, font: "Montserrat-ExtraLight", color: Color.white)
                                .padding([.top, .bottom], 6)
                            
                            
                            TextDesign(text: "\(product.price)դր.", size: 27, font: "Montserrat-ExtraLight", color: self.product.sale == 0 ? Color.white : Color.red)
                                .padding([.top, .bottom], 6)
                        }
                        
                        
                        if self.product.category != "Աքսեսուարներ" {
                            TextDesign(text: self.size, size: 25, font: "Montserrat-ExtraLight", color: Color.white)
                                .frame( width: UIScreen.main.bounds.size.width/2 - 40)
                                .background(Color( UIColor( red: 35/255, green: 204/255, blue: 214/255, alpha: 1)))
                                .cornerRadius(10)
                                .multilineTextAlignment(.leading)
                                .padding([.top, .bottom], 6)
                                .onTapGesture {
                                    self.activeSheet = .size
                                    self.showSheet.toggle()
                            }
                        }
                        
                        
                        Button(action: {
                            if ( self.size == "Չափս" && self.product.category != "Աքսեսուարներ" ) || self.color == "" {
                                self.activeAlert = .error
                                self.showAlert.toggle()
                            } else {
                                let cartModel = CartModel(product: self.product, size: self.size, color: self.color)
                                self.cartVM.cartProducts.append(cartModel)
                                self.activeAlert = .success
                                self.showAlert.toggle()
                            }
                        }) {
                            Text("Ավելացնել Զամբյուղ")
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
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scrollOptions(direction: .vertical, showsIndicators: false)
                    
                }
                
                
            }.alertX(isPresented: self.$showAlert) {
                if self.activeAlert == .error {
                    return AlertX(title: Text( "Սխալ"), message: Text( "Խնդրում ենք ընտրել չափը"), primaryButton: .default(Text( "Լավ" )), theme: .graphite(withTransparency: true, roundedCorners: true ), animation: .classicEffect())
                } else {
                    return AlertX(title: Text( "Շնորհավոր"), message: Text( "Այս ապրանքը ավելացվել է ձեր զամբյում:"), primaryButton: .default(Text( "Լավ" )), theme: .graphite(withTransparency: true, roundedCorners: true ), animation: .classicEffect())
                }
            }
            .sheet(isPresented: self.$showSheet) {
                if self.activeSheet == .arView {
                    ARContentVIew()
                } else if self.activeSheet == .size {
                    SizeSheet(sizeList: self.product.size, showSeet: self.$showSheet, selectedSize: self.$size)
                }
            }
            
        }.navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
    }
}
