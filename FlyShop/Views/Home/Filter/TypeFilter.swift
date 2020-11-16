//
//  TypeFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeFilter: View {
    
    @EnvironmentObject var filterVM : FilterViewModel
    @Binding var activeSheet: ActiveSheet
    @Binding var showSheet: Bool
    
    var body: some View {
        // Type Filter
        
        HStack {
            
            TextDesign(text: "Տիպ", size: 13, font: "Montserrat-ExtraLight", color: Color.black)
            
            
            Spacer()
            
            HStack {
                
                TextDesign(text: self.filterVM.type == "" ? "Ընտրեք տեսակը" : self.filterVM.type, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
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
                        
                        self.activeSheet = .type
                        self.showSheet.toggle()
                }
            }
        }
    }
}
