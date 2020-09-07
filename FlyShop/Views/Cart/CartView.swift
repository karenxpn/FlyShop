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
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var paymentVM = PaymentViewModel()
    @State private var showShippingItems: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                
                AllShopsBackground()
                
                VStack {
                    
                    if !self.cartVM.shippingProductsList.products.filter{ $0.shipped == false }.isEmpty {
                        VStack {
                            HStack {
                                Image( "shipping" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame( width: 100, height: 100 )
                                
                                Text( "Ապրանքներ որոնք ճանապարհին են" )
                            }.padding()
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                    .padding(4)
                        .shadow(color: Color.gray, radius: 8, x: 8, y: 8)
                        .onTapGesture {
                            self.showShippingItems = true
                            self.cartVM.shippingProducts()
                        }
                    }
                    
                    
                    if #available(iOS 14.0, *) {
                        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                        
                        AnyView( ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach( self.cartVM.cartProducts) {   product in
                                    CartItemPreview(product: product)
                                        .padding(.top, 12)
                                }
                            }
                        })
                        
                    } else {
                    
                        WaterfallGrid(self.cartVM.cartProducts) { product in
                            CartItemPreview(product: product)
                                .padding(.top, 12)
                        }
                    }
                    
                    Buy().environmentObject(self.paymentVM)
                    
                    NavigationLink(destination: ShippingItems().environmentObject(self.cartVM), isActive: self.$showShippingItems) {
                        EmptyView()
                    }
                }
            }.alertX(isPresented: self.$paymentVM.showAlert, content: {
                
                if self.paymentVM.activeAlert == .success {
                    return AlertX(title: Text( "Հաստատման Կոդ: \(self.paymentVM.paymentDetails!.ApprovalCode)" ), message: Text( "Վճարման կարգավիճակ: \(self.paymentVM.paymentDetails!.PaymentState)\nՔարտապանի անուն: \(self.paymentVM.paymentDetails!.ClientName)\nCard Number: \(self.paymentVM.paymentDetails!.CardNumber)\nԳումարը: \(formatDecimal(number: self.paymentVM.paymentDetails!.Amount))\nՀաստատված գումարը: \(formatDecimal(number: self.paymentVM.paymentDetails!.ApprovedAmount))\n" ), primaryButton: .default(Text("OK"), action: {
                        
                        let model = OrderDetails(PaymentID: self.paymentVM.paymentID, Amount: self.paymentVM.amount)
                        let cardHolder = self.paymentVM.paymentDetails!.ClientName
                        
                        self.cartVM.client = cardHolder
                        self.cartVM.orderDetails = model
                        self.cartVM.postProducts()
                        
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
                    return AlertX(title: Text( "Սխալ" ), message: Text( self.paymentVM.errorMessage ), primaryButton: .default(Text( "OK" )), theme: AlertX.Theme.custom(windowColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 0.3)),
                                                   alertTextColor: Color.white,
                                                   enableShadow: true,
                                                   enableRoundedCorners: true,
                                                   enableTransparency: true,
                                                   cancelButtonColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 1)),
                                                   cancelButtonTextColor: Color.white,
                                                   defaultButtonColor: Color(UIColor(red: 97/255, green: 61/255, blue: 231/255, alpha: 1)), defaultButtonTextColor: Color.white),
                        animation: .defaultEffect())
                }
            })
            .sheet(isPresented: self.$paymentVM.showAddress, onDismiss: {
                self.paymentVM.showWeb = false
            },content: {
                Address()
                    .environmentObject(self.paymentVM)
                    .environmentObject(self.cartVM)
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
    @EnvironmentObject var authVM: AuthViewModel

    
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
                    
                    Text( "\(countTotal())" )
                        .font(.custom("McLaren-Regular", size: 17))
                        .foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                    
                }
                HStack{
                    Spacer()
                    Button(action: {
                        
                        if self.countTotal() == 0 {
                             self.paymentVM.activeAlert = .error
                             self.paymentVM.showAlert = true
                             self.paymentVM.errorMessage = "Ավելացրեք ապրանքներ Ձեր զամբյուղում"

                         } else {
//                             add description for transaction
                            self.paymentVM.description = "Order"
                            self.paymentVM.amount = Decimal ( self.countTotal() )
                            self.paymentVM.initPayment()
                        }
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
    
    func countTotal() -> Int {
        
        var total = 0
        
        for product in self.cartVM.cartProducts {
            total += Int ( product.product.price )!
        }
        
        return total
    }
}
