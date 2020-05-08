//
//  NavigationTitleView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct NavigationTitleView: View {
    var body: some View {
        
        VStack( spacing: 10) {
            Text( "FlyShop")
                .font(.custom("McLaren-Regular", size: 20))
                .foregroundColor(Color.white)
            
            Rectangle().fill(Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1)).width(UIScreen.main.bounds.size.width * 0.5)
                .frame( height: 2)
            
        }
    }
}

struct NavigationTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTitleView()
    }
}
