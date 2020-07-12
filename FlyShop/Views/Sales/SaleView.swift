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
                    TopChat(message: "Կարծես թե զեղչեր ունենք:\nԲաց մի՛ թող այս հնարավորությունը:")
                    
                    if #available(iOS 14.0, *) {
                        let rows: [GridItem] = Array(repeating: .init(.fixed( UIScreen.main.bounds.size.height/3.5)), count: 2)

                        
                        ScrollView( .horizontal ) {
                            LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                                ForEach( self.saleVM.productsUnderSale, id: \.id) { product in
                                    SingleSaleProduct(product: product)
                                }
                            }
                        }
                    } else {
                        WaterfallGrid(self.saleVM.productsUnderSale) { product in
                            SingleSaleProduct(product: product)
                        }.scrollOptions(direction: .horizontal, showsIndicators: false).gridStyle(
                            animation: .easeInOut(duration: 0.5)
                        )
                    }
                    

                    
                   BottomChat()
                }
                
//                if self.saleVM.showLoading {
//                    Loading()
//                }
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
