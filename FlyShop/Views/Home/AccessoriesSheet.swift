//
//  AccessoriesSheet.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct AccessoriesSheet: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var showSheet: Bool
    let typeArray: [String]
    @State private var checkList = [Bool]( repeating: false, count: 20)
    
    
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
                Text( "Save" )
                    .font(.custom("Montserrat-Italic", size: 16))
                    .foregroundColor(.white)
                
            }))
        }
    }
}

struct AccessoriesSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccessoriesSheet(showSheet: .constant(false), typeArray: [""])
    }
}
