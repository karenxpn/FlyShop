//
//  MainScreen.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    @State private var selected = [false, false, true, false, false]
    let selectedColor = Color(red: 218/255, green: 218/255, blue: 218/255, opacity: 0.6)
    let tabItems = TabItemModel.getTabItems()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .white
    }
    
    var body: some View {
        
        ZStack {
            Color( #colorLiteral(red: 0.09298879653, green: 0.07001345605, blue: 0.1453302801, alpha: 1) ).edgesIgnoringSafeArea(.top)
            VStack {
                Spacer()
                
                if self.viewRouter.currentView == "allShops" {
                    Text( "allShops" )
                } else if self.viewRouter.currentView == "new" {
                    Text( "new")
                } else if self.viewRouter.currentView == "main" {
                    HomeView()
                } else if self.viewRouter.currentView == "sales" {
                    Text( "sales" )
                } else if self.viewRouter.currentView == "cart" {
                    Text( "cart" )
                }
                
                Spacer()
                
                HStack( alignment: .top) {
                    List {
                        HStack {
                            ForEach( 0..<self.tabItems.count ) { index in
                                ZStack {
                                    Circle().foregroundColor(self.selected[index] ? self.selectedColor : Color.white)
                                        .frame(width: 40, height: 40)
                                    
                                    self.tabItems[index].image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.size.width/6, height: UIScreen.main.bounds.size.width/6)
                                        .onTapGesture {
                                            self.designSelectedItem(index: index)
                                            self.viewRouter.currentView = self.tabItems[index].title
                                    }
                                }
                            }
                        }
                    }
                }.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/10.5)
                
                
            }.edgesIgnoringSafeArea(.bottom)
        }
        
    }
    
    func designSelectedItem ( index: Int ) {
        for i in 0..<self.selected.count {
            self.selected[i] = false
        }
        
        self.selected[index] = true
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
