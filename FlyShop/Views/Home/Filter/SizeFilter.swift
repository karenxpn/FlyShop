//
//  SizeFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct SizeFilter: View {
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var activeSheet: ActiveSheet
    @Binding var showSheet: Bool
    @Binding var showAlert: Bool
    var body: some View {
        HStack {
            TextDesign(text: "Չափը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            
            
            Spacer()
            
            HStack {
                
                TextDesign(text: self.filterVM.size.isEmpty ? "Ձեր չափը" : self.getSizes(), size: 14, font: "Montserrat-ExtraLight", color: Color.white)
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
                        if ( self.filterVM.gender != "" ) && ( self.filterVM.category == "Հագուստ" || self.filterVM.category == "Կոշիկ" ) && self.filterVM.type != "" {
                            self.activeSheet = .size
                            self.showSheet = true
                        }
                        else {
                            self.showAlert.toggle()
                        }
                }
            }
        }
    }
    
    func getSizes() -> String {
        var sizeString = ""
        for i in 0..<self.filterVM.size.count {
            if i != self.filterVM.size.count-1 {
                sizeString += self.filterVM.size[i] + ","
            } else {
                sizeString += self.filterVM.size[i]
            }
        }
        return sizeString
    }
}

struct SizeFilter_Previews: PreviewProvider {
    static var previews: some View {
        SizeFilter(activeSheet: .constant(.brand), showSheet: .constant(false), showAlert: .constant(false))
    }
}
