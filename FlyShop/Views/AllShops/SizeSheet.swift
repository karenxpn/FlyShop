//
//  SizeSheet.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/10/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct SizeSheet: View {
    
    let sizeList: [String]
    @Binding var showSeet: Bool
    @Binding var selectedSize: String
    @State private var checkList = [Bool]( repeating: false, count: 20)
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach( 0..<sizeList.count) { index in
                        
                        HStack {
                            Text( self.sizeList[index] )
                                .foregroundColor(Color.black)
                                .font(.system(size: 23))
                            
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
                            self.selectedSize = self.sizeList[index]
                        }
                    }
                }
            }
            .navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showSeet = false
            }, label: {
                Text( "Save" )
                    .foregroundColor(Color.white)
                    .font( .custom("Montserrat-Italic", size: 16))
                
            }))
        }
    }
    
    
}

struct SizeSheet_Previews: PreviewProvider {
    static var previews: some View {
        SizeSheet(sizeList: ["XS", "S", "M", "L", "XL", "XXL", "XXXL"], showSeet: .constant(false), selectedSize: .constant(""))
    }
}
