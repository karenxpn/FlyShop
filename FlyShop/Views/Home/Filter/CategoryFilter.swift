//
//  CategoryFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

struct CategoryFilter: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    var body: some View {
        // CategoryFilter
        HStack {
            
            TextDesign(text: "Կատեգորիա", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            
            Spacer()
            
            ForEach(FilterTypeModel().categories(), id: \.self) { category in
                
                TextDesign(text: category, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.top, .bottom], 8)
                    .padding([.horizontal], 10)
                .lineLimit(1)
                    .background( self.filterVM.category == category ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray)
                    .cornerRadius(20)
                    .onTapGesture {
                        self.filterVM.type = ""
                        self.filterVM.category = category
                }
                
            }
            
        }.padding([.bottom, .top], 6)
    }
}
