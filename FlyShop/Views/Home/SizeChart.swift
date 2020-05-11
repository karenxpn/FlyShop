//
//  SizeChart.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct SizeChart: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var showSheet: Bool
    
    let gender: String
    let category: String
    let type: String
    @State private var checkList = [Bool]( repeating: false, count: 20)
    
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach( 0..<SizeModel().sizeChart(gender: self.gender, category: self.category, type: self.type).count) { index in
                    HStack {
                        Text( SizeModel().sizeChart(gender: self.gender, category: self.category, type: self.type)[index] )
                        Spacer()
                        if self.checkList[index] == true {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }.padding()
                        .onTapGesture {
                            self.checkList[index].toggle()
                    }
                }
                Spacer()
            }
        .navigationBarHidden(false)
            .navigationBarTitle(Text("Choose yor size"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
                self.filterVM.size.removeAll(keepingCapacity: false)
                
                for index in 0..<SizeModel().sizeChart( gender: self.gender, category: self.category, type: self.type ).count {
                    if self.checkList[index] == true {
                        self.filterVM.size.append(SizeModel().sizeChart( gender: self.gender, category: self.category, type: self.type)[index])
                    }
                }
                
                self.showSheet.toggle()
            }, label: {
                Text( "Save" )
                    .font(.custom("Montserrat-Italic", size: 16))
                    .foregroundColor(.white)
        }))
        }
    }
}

struct SizeChart_Previews: PreviewProvider {
    static var previews: some View {
        SizeChart(showSheet: .constant(false), gender: "", category: "", type: "")
    }
}
