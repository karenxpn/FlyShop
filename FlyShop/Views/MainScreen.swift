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
        
        VStack {
            
            if self.viewRouter.currentView == "allShops" {
                Text( "allShops" ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else if self.viewRouter.currentView == "new" {
                Text( "new").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else if self.viewRouter.currentView == "main" {
                HomeView().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else if self.viewRouter.currentView == "sales" {
                Text( "sales" ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else if self.viewRouter.currentView == "cart" {
                Text( "cart" ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            HStack( alignment: .top) {
                HStack {
                    ForEach( 0..<self.tabItems.count ) { index in
                        ZStack {
                            Circle().foregroundColor(self.selected[index] ? self.selectedColor : Color.white)
                                .frame(width: 50, height: 50)
                            
                            self.tabItems[index].image
                                .resizable()
                                .aspectRatio(contentMode: index == 2 ? .fill : .fit)
                                .padding()
                                .frame(width: UIScreen.main.bounds.size.width/6, height: UIScreen.main.bounds.size.width/5)
                                .onTapGesture {
                                    self.designSelectedItem(index: index)
                                    self.viewRouter.currentView = self.tabItems[index].title
                            }
                        }
                    }
                }
            }.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/15)
                .padding(.bottom, 15)
            
            
        }.edgesIgnoringSafeArea(.bottom)
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
