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
    
    
    @State private var offset: CGFloat = 200
    @State private var animate: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                AllShopsBackground()
                
                if self.saleVM.showLoading {
                    Loading()
                } else {
                    
                    VStack {
                        TopChat(message: "Կարծես թե զեղչեր ունենք:\nԲաց մի՛ թող այս հնարավորությունը:")
                        
                        
                        if #available(iOS 14.0, *) {

                            let rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                            
                            AnyView( ScrollView( .horizontal ) {
                                LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                                    ForEach( self.saleVM.productsUnderSale, id: \.id) { product in
                                        SingleSaleProduct(product: product)
                                            .offset(y: animate ? 0 : offset)
                                            .animation(
                                                Animation.interpolatingSpring(stiffness: 70, damping: 10)
                                                    .delay(0.2)
                                            ).onAppear {
                                                animate = true
                                            }
                                    }
                                }
                            }.frame(maxHeight: .infinity))
                        } else {
                            WaterfallGrid(self.saleVM.productsUnderSale) { product in
                                SingleSaleProduct(product: product)
                            }.scrollOptions(direction: .horizontal, showsIndicators: false).gridStyle(
                                animation: .easeInOut(duration: 0.5)
                            )
                        }
                        
                        BottomChat()
                    }
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
