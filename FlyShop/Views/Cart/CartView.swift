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
                            WaterfallGrid(self.cartVM.cartProducts) { product in
                                CartItemPreview(product: product)
                                    .padding(.top, 12)
                            }

                            Spacer()
                            
                            CheckAvailability()

  
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        

            }
            .navigationBarTitle(Text( ""), displayMode: .inline)
            .navigationBarItems(leading: CartNavigationText(), trailing: CartNavigationView())
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


struct CheckAvailability: View {
    var body: some View {
        ZStack {
            
            Image("cartBottom")
                      .resizable()
                          .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/7)
            HStack{
                Spacer()
                Button(action: {
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
