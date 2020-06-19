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
import Alamofire
import AlertX


struct CartView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    @ObservedObject var paymentVM = PaymentViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AllShopsBackground()
                
                VStack {
                    
                    
                    WaterfallGrid(self.cartVM.cartProducts) { product in
                        CartItemPreview(product: product)
                            .padding(.top, 12)
                    }
                    
                    Buy().environmentObject(self.paymentVM)
                    
                    NavigationLink(destination: PaymentWebView().environmentObject(self.paymentVM), isActive: self.$paymentVM.showWeb) {
                        EmptyView()
                    }
                }
            }
            .alertX(isPresented: self.$paymentVM.showAlert, content: {
                
                if self.paymentVM.paymentDetails != nil {
                    return AlertX(title: Text( "Հաստատման Կոդ: \(self.paymentVM.paymentDetails!.ApprovalCode)" ), message: Text( "Վճարման կարգավիճակ: \(self.paymentVM.paymentDetails!.PaymentState)\nՔարտապանի անուն: \(self.paymentVM.paymentDetails!.ClientName)\nCard Number: \(self.paymentVM.paymentDetails!.CardNumber)\nԳումարը: \(formatDecimal(number: self.paymentVM.paymentDetails!.Amount))\nՀաստատված գումարը: \(formatDecimal(number: self.paymentVM.paymentDetails!.ApprovedAmount))\n" ), primaryButton: AlertX.Button.default(Text("OK"), action: {
                        print("Complete Payment")
                    }), theme: AlertX.Theme.custom(windowColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 0.3)),
                                                   alertTextColor: Color.white,
                                                   enableShadow: true,
                                                   enableRoundedCorners: true,
                                                   enableTransparency: true,
                                                   cancelButtonColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 1)),
                                                   cancelButtonTextColor: Color.white,
                                                   defaultButtonColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 1)), defaultButtonTextColor: Color.white),
                        animation: .defaultEffect())
                } else {
                    return AlertX(title: Text( "" ))
                }

            })
            
                .navigationBarTitle(Text( ""), displayMode: .inline)
                .navigationBarItems(leading: CartNavigationText(title: self.cartVM.navTitle), trailing: CartNavigationView())
        }
    }
    
    func formatDecimal(number: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: number as NSDecimalNumber)!
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


struct Buy: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var paymentVM: PaymentViewModel
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
                        
                        for product in self.cartVM.cartProducts {
                            self.paymentVM.description += ( "\(product.product.name)" )
                        }
                        
                        self.paymentVM.initPayment()
                    }) {
                        Text( "Գնել")
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
                }.offset(y: UIScreen.main.bounds.size.height/55)
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
