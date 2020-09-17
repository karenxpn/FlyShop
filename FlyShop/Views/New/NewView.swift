//
//  NewView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct NewView: View {
    
    @ObservedObject var newVM = NewViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                AllShopsBackground()
                
                if self.newVM.showLoading {
                    Loading()
                } else {
                    
                    VStack{
                        TopChat(message: "Բարեւ Ձեզ!\nՄենք նոր տեսականի ունենք Ձեզ համար:")

                        if #available(iOS 14.0, *) {
                            let rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                            AnyView ( ScrollView( .horizontal ) {
                                LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                                    ForEach( self.newVM.newItemList, id: \.id) { product in
                                        SingleNewProduct(product: product)
                                    }
                                }
                            }.frame(maxHeight: .infinity))


                        } else {
                            WaterfallGrid(self.newVM.newItemList) { product in
                                SingleNewProduct(product: product)
                            }.scrollOptions(direction: .horizontal, showsIndicators: false).gridStyle(
                                animation: .easeInOut(duration: 0.5)
                            )
                        }
                        
                        BottomChat()
                    }
                }
                
            }.navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }
    }
    
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}

struct TopChat: View {
    
    let message: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            Image("main" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .background(Color(UIColor(red: 21/255, green: 23/255, blue: 41/255, alpha: 1)))
                .cornerRadius(35)
            
            
            ZStack {
                
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 0.391, green: 0.352, blue: 1, alpha: 1)), Color(UIColor(red: 0.647, green: 0.451, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    //this is the gradient for the background
                    .frame(width: UIScreen.main.bounds.size.width-110, height: UIScreen.main.bounds.size.height == 896.0 ? UIScreen.main.bounds.size.height/12 : UIScreen.main.bounds.size.height/14)
                    .cornerRadius(10, corners: [.topLeft, .topRight, .bottomRight])
                
                TextDesign(text: message, size: 13, font: "Montserrat-ExtraLight", color: Color.white)
                
                
            }.padding(.leading, 12)
        }.padding([.leading, .top], 20)
    }
}

struct BottomChat: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 0.175, green: 0.788, blue: 0.921, alpha: 1)), Color(UIColor(red: 0.078, green: 0.824, blue: 0.722, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        //this is the gradient for the background
                        .frame(width: UIScreen.main.bounds.size.width-200, height: UIScreen.main.bounds.size.height/13)
                        .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft])
                    
                    TextDesign(text: "Բարի! Հիմա կնայեմ:", size: 13, font: "Montserrat-ExtraLight", color: Color.white)
                    
                    
                }.padding(.leading, 12)
            }.padding([.bottom, .trailing])
            
            TextDesign(text: self.getDate() + "PM", size: 11, font: "Montserrat-ExtraLight", color: Color.gray)
                .offset(x: UIScreen.main.bounds.size.width/2.5, y: -20 )
        }
    }
    
    func getDate() -> String{
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
    
}
