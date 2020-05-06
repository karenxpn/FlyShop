//
//  HomeView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        
        NavigationView {
            ZStack {
                HomeViewBackground()
                
                VStack {
                    HStack {
                        Spacer()
                        Text( "TRENDS" ).font(.custom("Montserrat-Italic", size: 28))
                            .foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1)).offset( x: 18)
                        
                        
                        Spacer()
                        
                        // open the filter view
                        NavigationLink (destination: FilterView()) {
                            Image( "filter" )
                                .renderingMode(.original)
                            
                        }
                                           
                        
                        // The list here should represent trends etc.
                    }
                    Spacer()
                }
                
            }.navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }

        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
