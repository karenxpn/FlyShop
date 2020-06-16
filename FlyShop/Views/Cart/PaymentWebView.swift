//
//  PaymentWebView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/16/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct PaymentWebView: View {
    
    @EnvironmentObject var paymentVM: PaymentViewModel
    
    var body: some View {
        WebView( url: "https://servicestest.ameriabank.am/VPOS/Payments/Pay?id=\(self.paymentVM.paymentID)&lang=am" )
    }
}

struct PaymentWebView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentWebView()
    }
}
