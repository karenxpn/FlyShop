//
//  HomeView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        //UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "McLaren-Regular", size: 20)!]
        
    }
    var body: some View {
        
        NavigationView {
            ZStack {
                HomeViewBackground()
                
                VStack {
                    HStack {
                        Spacer()
                        Text( "TRENDS" ).font(.custom("Montserrat-Italic", size: 28))
                            .foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))

                        
                        Spacer()
                        
                        Image( "filter" )
                        // open the filter view
                    }
                    Spacer()
                }
                
            }.navigationBarTitle(Text("FlyShop"), displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = #colorLiteral(red: 0.01536641922, green: 0.002536598593, blue: 0.0852348879, alpha: 1)
            })
        }    .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
