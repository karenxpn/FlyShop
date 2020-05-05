//
//  MainScreen.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            Text( "All Shops" ).tabItem {
                Image ( "allShops" )
            }
            
            Text( "New" ).tabItem {
                Image( "new" )
                .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            }
            
            HomeView().tabItem {
                Image( "main" )
                .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            }
            
            Text( "sales" ).tabItem {
                Image( "sales" )
                .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            }
            
            Text( "Cart" ).tabItem {
                Image( "cart" )
                .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
