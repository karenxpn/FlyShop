//
//  BrandFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

struct BrandFilter: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var activeSheet: ActiveSheet
    @Binding var showSheet: Bool
    
    var body: some View {
        // Brand Filter
        HStack {
            
            TextDesign(text: "Ապրանքանիշը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            Spacer()
            
            HStack {
                
                TextDesign(text:  self.filterVM.brand == "" ? "Ընտրեք ապրանքանիշը" : self.filterVM.brand, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.top, .bottom], 6)
                    .padding([.trailing, .leading], 12)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(20)
                
                TextDesign(text: "+", size: 20, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.leading, .trailing], 12)
                    .padding([.top, .bottom], 6)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(30)
                    .onTapGesture {
                        print("Clicked")
                        self.activeSheet = .brand
                        self.showSheet.toggle()
                }
            }
        }
    }
}
