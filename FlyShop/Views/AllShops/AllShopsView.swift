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
    
    @State private var showSearch: Bool = false
    @State private var search: String = ""
    @ObservedObject var allShopVM = AllShopsViewModel()
    
    
    @State private var offset: CGFloat = 200
    @State private var animate: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AllShopsBackground()
                
                if self.allShopVM.showLoading == true {
                    Loading()
                        .zIndex(3)
                } else {
                    VStack{
                        
                        ZStack {
                            Image("searchRectangle")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/10)
                            
                            VStack( spacing: 0) {
                                Text( "Խանութների Ցանկ" ).foregroundColor( Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1))
                                    .font(.custom("McLaren-Regular", size: 25))
                                
                                if showSearch {
                                    
                                    // search field here
                                    // as soon as the keyboard is closed search field should close and the search button appear
                                    TextField("Search", text: self.$search)
                                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                                        .padding([.leading, .trailing])
                                        .padding([.vertical], 6)
                                        .background(Color.gray)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .offset(y: 10)
                                    
                                } else {
                                    
                                    Image("searchicon")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.size.width/13, height: UIScreen.main.bounds.size.height/27)
                                        .onTapGesture {
                                            withAnimation{
                                                self.showSearch = true
                                            }
                                        }
                                }
                            }
                        }.zIndex(1)
                        
                        if #available(iOS 14.0, *) {
                            let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                            AnyView( ScrollView {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach( self.allShopVM.allShops
                                                .filter{
                                                    self.search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.search)
                                                } ) {   shop in
                                        AllShopGridCell(shopModel: shop).padding(.bottom, UIScreen.main.bounds.size.height/25)
                                                .offset(y: animate ? 0 : offset)
                                                .animation(
                                                    Animation.interpolatingSpring(stiffness: 70, damping: 10)
                                                        .delay(0.2)
                                                ).onAppear {
                                                    animate = true
                                                }
                                    }
                                }.zIndex(0)
                                .transition(AnyTransition.slide)
                                .animation(.default)
                                .offset(y: self.showSearch ? 10 : 0)
                            })

                        } else {
                            WaterfallGrid( self.allShopVM.allShops
                                            .filter{
                                                self.search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.search)
                                            }) { shop in
                                AllShopGridCell(shopModel: shop).padding(.bottom, UIScreen.main.bounds.size.height/25)
                                
                            }.transition(AnyTransition.slide)
                            .animation(.default)
                            .offset(y: self.showSearch ? 10 : 0)
                        }
                    }
                    .gesture(DragGesture().onChanged{_ in
                        self.showSearch = false
                        UIApplication.shared.endEditing()
                    })
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.search = ""
            }, label: {
                TextDesign(text: "Մաքրել", size: 18, font: "Montserrat-ExtraLight", color: Color.white)
            }))
            .navigationBarTitle(Text("FlyShop"), displayMode: .inline)
        }
    }
}

struct AllShopsView_Previews: PreviewProvider {
    static var previews: some View {
        AllShopsView()
    }
}
