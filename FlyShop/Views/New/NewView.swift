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
                
                VStack {
                    TopChat()
                    
                    Spacer()
                    
                    WaterfallGrid(self.newVM.newItemList) { product in
                        SingleNewProduct(product: product)
                    }.gridStyle(
                        columns: 2,
                        animation: .easeInOut(duration: 0.5)
                    ).scrollOptions(direction: .horizontal, showsIndicators: false)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                
                                Rectangle().fill(Color(UIColor(red: 20/255, green: 210/255, blue: 184/255, alpha: 1)))
                                    //this is the gradient for the background
                                    .frame(width: UIScreen.main.bounds.size.width-200, height: UIScreen.main.bounds.size.height/13)
                                    .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft])
                                
                                Text( "Sounds Good!\nI have to check now!")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat-Italic", size: 14))
                                
                            }.padding(.leading, 12)
                        }.offset(x: -10, y: -20)
                        
                        Text( self.getDate() + "PM" )
                            .foregroundColor(Color.gray)
                            .font(.custom("Montserrat-Italic", size: 12))
                            .offset(x: UIScreen.main.bounds.size.width/2.5, y: -20)
                        
                    }
                    
                }
                
                
                
                
            }.navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }
    }
    
    func getDate() -> String{
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:ss"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}

struct TopChat: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Image("Circle" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .background(Color( UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)))
                .cornerRadius(35)
            
            
            ZStack {
                
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 0.391, green: 0.352, blue: 1, alpha: 1)), Color(UIColor(red: 0.647, green: 0.451, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    //this is the gradient for the background
                    .frame(width: UIScreen.main.bounds.size.width-110, height: UIScreen.main.bounds.size.height/13)
                    .cornerRadius(10, corners: [.topLeft, .topRight, .bottomRight])
                
                Text( "Hi, we have something new for you!")
                    .foregroundColor(Color.white)
                    .font(.custom("Montserrat-Italic", size: 14))
                
                
                
            }.padding(.leading, 12)
        }.offset(x: 10, y: 20)
    }
}
