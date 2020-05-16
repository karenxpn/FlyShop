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
    @State private var checkList = [Bool]( repeating: false, count: 20)
    @Binding var showSheet: Bool
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach( 0..<self.allShopVM.allShops.count, id: \.self) { index in
                    HStack {
                        Text( self.allShopVM.allShops[index].name )
                            .foregroundColor(Color.black)
                        Spacer()
                        if self.checkList[index] == true {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }.onTapGesture {
                        for checkIndex in 0..<self.checkList.count {
                            self.checkList[checkIndex] = false
                        }
                        
                        self.checkList[index].toggle()
                        self.filterVM.brand = self.allShopVM.allShops[index].name
                    }
                }
            }
            .navigationBarTitle(Text( "Fly Shop"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showSheet.toggle()
            }, label: {
                
                TextDesign(text: "Save", size: 15, font: "Montserrat-ExtraLight", color: Color.white)
                
            }))
        }
    }
}

struct BrandSheet_Previews: PreviewProvider {
    static var previews: some View {
        BrandSheet( showSheet: .constant(false))
    }
}
