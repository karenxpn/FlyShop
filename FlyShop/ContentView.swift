//
//  ContentView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var authVM = AuthViewModel()
    
    var body: some View {
        VStack {
            if authVM.userLogged == true {
                MainScreen()
            } else if Auth.auth().currentUser != nil {
                MainScreen()
            } else {
                SignUp()
            }
        }.environmentObject(self.authVM)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
