//
//  SaleView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct SaleView: View {
    
    @ObservedObject var saleVM = SaleViewModel()
    
    var body: some View {

        NavigationView {
            ZStack {
                AllShopsBackground()
                
                VStack {
                    TopChat(message: "It looks like we have SALES\nHurry up to get something!")
                    
                    WaterfallGrid(self.saleVM.productsUnderSale) { product in
                        SingleSaleProduct(product: product)
                    }.scrollOptions(direction: .horizontal, showsIndicators: false)
                    
                    BottomChat()
                }
            }
            .navigationBarTitle(Text( "FlyShop"), displayMode: .inline)
        }
    }
}

struct SaleView_Previews: PreviewProvider {
    static var previews: some View {
        SaleView()
    }
}
