//
//  Address.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct Address: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var paymentVM: PaymentViewModel
    @State private var alert: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                AllShopsBackground()
                
                VStack( spacing: 20) {
                    
                    NavigationLink(destination: PaymentWebView().environmentObject(self.paymentVM), isActive: self.$paymentVM.showWeb) {
                        EmptyView()
                    }
                    
                    Image("main")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    TextField("Address", text: self.$cartVM.address)
                        .foregroundColor(Color.black)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Button(action: {
                        if self.cartVM.address == "" {
                            self.alert.toggle()
                        } else {
                            self.paymentVM.showWeb = true
                        }
                    }) {
                        Text( "Proceed" )
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                    }
                    
                    Text( "Ձեր ընտրությունը" )
                        .foregroundColor(Color.white)
                        .font( .custom("Montserrat-Light", size: 14))
                        .padding()
                    
                    Text( "Մեր հոգսն է" )
                        .foregroundColor(Color.white)
                        .font( .custom("Montserrat-Light", size: 20))
                        .padding(6)
                }
            }
            
            .alert(isPresented: self.$alert) {
                Alert(title: Text( "Error" ), message: Text( "Fill in the address" ), dismissButton: .default(Text( "OK" )))
            }
            .navigationBarTitle(Text( "FlyShop" ), displayMode: .inline)
        }
    }
}

struct Address_Previews: PreviewProvider {
    static var previews: some View {
        Address()
    }
}
