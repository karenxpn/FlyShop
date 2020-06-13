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
    @State private var checkList = [Bool]( repeating: false, count: 20)
    @Binding var showSheet: Bool
    let typeArray: [String]
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach( 0..<self.typeArray.count ) { index in
                    HStack {
                        Text( self.typeArray[index] )
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
                        self.filterVM.type = self.typeArray[index]
                    }
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
