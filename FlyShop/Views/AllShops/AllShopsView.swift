//
//  AllShopsView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct AllShopsView: View {
    
    @ObservedObject var allShopVM = AllShopsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AllShopsBackground()
                
                VStack( spacing: 6) {
                    
                    ZStack {
                        Image("searchRectangle")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/10)
                        
                        Text( "Shops List" ).foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                            .offset( y: -UIScreen.main.bounds.size.height/45)
                            .font(.custom("McLaren-Regular", size: 25))
                        
                        Image("searchicon")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width/13, height: UIScreen.main.bounds.size.height/27)
                            .offset(y: UIScreen.main.bounds.size.height/50)
                    }
                    
                    WaterfallGrid( self.allShopVM.allShops) { shop in
                        AllShopGridCell(shopModel: shop).padding(.bottom, UIScreen.main.bounds.size.height/25)
                    }.gridStyle(
                        animation: .easeInOut(duration: 0.5)
                    )
                }
                
                if self.allShopVM.showLoading {
                    Loading()
                }
            }
                
            .navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }
    }
}

struct AllShopsView_Previews: PreviewProvider {
    static var previews: some View {
        AllShopsView()
    }
}
