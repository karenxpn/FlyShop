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
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach( 0..<sizeList.count) { index in
                    
                    Button(action: {
                        self.selectedSize = self.sizeList[index]
                        self.showSeet = false
                    }, label: {
                        Text( self.sizeList[index] )
                            .foregroundColor(Color.black)
                            .font(.system(size: 23))
                    })

                }
            }
            .navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
        }
    }
    
    
}

struct SizeSheet_Previews: PreviewProvider {
    static var previews: some View {
        SizeSheet(sizeList: ["XS", "S", "M", "L", "XL", "XXL", "XXXL"], showSeet: .constant(false), selectedSize: .constant(""))
    }
}
