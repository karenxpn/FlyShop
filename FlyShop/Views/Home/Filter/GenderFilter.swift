//
//  GenderFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct GenderFilter: View {
    @EnvironmentObject var filterVM: FilterViewModel
    var body: some View {
        HStack {
            
            TextDesign(text: "Սեռը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            Spacer()
            
            ZStack {
                
                Circle().fill( self.filterVM.gender == "Իգական" ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray).frame(width: 40, height: 40)
                
                Image( "womenGender" )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }.padding(2)
                .onTapGesture {
                    self.filterVM.gender = "Իգական"
            }
            
            ZStack {
                
                Circle().fill(self.filterVM.gender == "Արական" ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray).frame(width: 40, height: 40)
                
                Image( "manGender" )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }.padding(2)
                .onTapGesture {
                    self.filterVM.gender = "Արական"
            }
            
        }    }
}

struct GenderFilter_Previews: PreviewProvider {
    static var previews: some View {
        GenderFilter()
    }
}
