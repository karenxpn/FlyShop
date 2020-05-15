//
//  CartView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SwiftUIX
import WaterfallGrid


struct CartView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AllShopsBackground()
                
                VStack {
                    
                    
                    Spacer()
                    
                    if UserDefaults.standard.bool(forKey: "InReview") == true {
                        WaterfallGrid(self.cartVM.reviewProducts) { product in
                            Review(product: product)
                                .padding(.top, 12)
                        }
                        
                    } else {
                        WaterfallGrid(self.cartVM.cartProducts) { product in
                            CartItemPreview(product: product)
                                .padding(.top, 12)
                        }
                        
                        CheckAvailability()
                    }
                }
                
                
                
            }
            .navigationBarTitle(Text( ""), displayMode: .inline)
            .navigationBarItems(leading: CartNavigationText(title: self.cartVM.navTitle), trailing: CartNavigationView())
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


struct CheckAvailability: View {
    @EnvironmentObject var cartVM: CartViewModel
    var body: some View {
        ZStack {
            
            Image("cartBottom")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/7)
            VStack {
                
                HStack {
                    Text( "Total" )
                        .font(.custom("McLaren-Regular", size: 17))
                        .foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                    
                    Text( "\(coutTotal())" )
                        .font(.custom("McLaren-Regular", size: 17))
                        .foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                    
                }
                HStack{
                    Spacer()
                    Button(action: {
                        
                        self.cartVM.postProductsToReview()
                        // Do the check here
                        // Post all items to firebase under userId and maka calls)))
                    }) {
                        Text( "Check Availability")
                            .foregroundColor(Color.white)
                            .font(.custom("McLaren-Regular", size: 15))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 0.3)))
                        )
                    }
                    Spacer()
                }.offset(y:20)
            }
        }
    }
    
    func coutTotal() -> Int {
        
        var total = 0
        
        for product in self.cartVM.cartProducts {
            total += Int ( product.product.priceWithSale )!
        }
        
        return total
    }
}
