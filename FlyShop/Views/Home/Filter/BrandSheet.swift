//
//  BrandSheet.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct BrandSheet: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @ObservedObject var allShopVM = AllShopsViewModel()
    @Binding var showSheet: Bool
    
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach( 0..<self.allShopVM.allShops.count, id: \.self) { index in
                    
                    Button(action: {
                        self.filterVM.brand = self.allShopVM.allShops[index].name
                        self.showSheet = false
                    }, label: {
                        Text( self.allShopVM.allShops[index].name )
                            .foregroundColor(Color.black)
                    })

                }
            }
            .navigationBarTitle(Text( "Fly Shop"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showSheet.toggle()
            }, label: {
                
                TextDesign(text: "Պահպանել", size: 15, font: "Montserrat-ExtraLight", color: Color.white)
                
            }))
        }
    }
}

struct BrandSheet_Previews: PreviewProvider {
    static var previews: some View {
        BrandSheet( showSheet: .constant(false))
    }
}
