//
//  TypeSheet.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/14/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct TypeSheet: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var showSheet: Bool
    let typeArray: [String]
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach( 0..<self.typeArray.count ) { index in
                    Button(action: {
                        self.filterVM.type = self.typeArray[index]
                        self.showSheet = false
                    }, label: {
                        Text( self.typeArray[index] )

                    })
                }
            }
            .navigationBarTitle(Text( "FlyShop"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showSheet.toggle()
            }, label: {
                
                TextDesign(text: "Պահպանել", size: 15, font: "Montserrat-ExtraLight", color: Color.white)
            }))
        }
    }
}

//struct TypeSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TypeSheet(showSheet: .constant(false))
//    }
//}
