//
//  ContentView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authVM = AuthViewModel()
    
    var body: some View {
            ZStack {
                Background()
                
                if authVM.userLogged == false {
                    SignUp()
                } else if authVM.userLogged == true {
                    MainScreen()
                }
            }.environmentObject(self.authVM)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
