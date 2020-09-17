//
//  FilterResult.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct FilterResult: View {
    
    @EnvironmentObject var filterVM: FilterViewModel    
    
    var body: some View {
        ZStack {
            
            AllShopsBackground()
            
            
            VStack( spacing: 6) {
                
                ZStack {
                    Image("searchRectangle")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/10)
                    
                    VStack( spacing: 0) {
                        Text( self.filterVM.category ).foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                            .font(.custom("McLaren-Regular", size: 25))
                        
                    }
                }
                
                if #available(iOS 14.0, *) {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    AnyView( ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(self.filterVM.filteredItems ) {   product in
                                SingleProduct(product: product)
                            }
                        }.transition(AnyTransition.slide)
                        .animation(.default)
                    })

                } else {
                
                    WaterfallGrid( self.filterVM.filteredItems) { product in
                        SingleProduct(product: product)
                    }.transition(AnyTransition.slide)
                        .animation(.default)
                }
                
            }
        }
            
        .navigationBarTitle(Text("FlyShop"), displayMode: .inline)
    }
}

struct FilterResult_Previews: PreviewProvider {
    static var previews: some View {
        FilterResult()
    }
}
