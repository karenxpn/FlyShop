//
//  HomeView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var homeVM = HomeViewModel()
    @State private var selection: String = ""
    let coursor = [Image("cursor"), Image("cursor"), Image("cursor"), Image("cursor"), Image("cursor")]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                HomeViewBackground()
                
                VStack {
                    
                    Header()
                    
                    Spacer()
                    
                    
                    TrendGrid().environmentObject(self.homeVM)
                    
                    Spacer()
                    
                    CategorySelector().environmentObject(self.homeVM)
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

struct CategorySelector: View {
    
    let categoryImages = ["clothes", "shoes", "accessories"]
    let categoryNames = ["Clothes", "Shoes", "Accessories"]
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        
        HStack {
            ForEach( 0..<self.categoryImages.count ) { index in
                HStack {
                    
                    HStack {
                        Image( self.categoryImages[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text( self.categoryNames[index])
                            .font(.custom("Montserrat-Italic", size: 14))
                            .foregroundColor(Color.white)
                        
                    }.padding(.vertical, 5)
                        .padding(.horizontal, 10)
                    
                    
                }.background( self.homeVM.category == self.categoryNames[index] ? Color(UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 1)) : Color.clear )
                    .cornerRadius(15)
                    .padding(.top, 12)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        self.homeVM.category = self.categoryNames[index]
                        self.homeVM.getTrends()
                }
            }
        }
    }
}


struct Header: View {
    var body: some View {
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
        }
    }
}

struct TrendGrid: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        
        ZStack {
            
            if self.homeVM.trendList.isEmpty == false {
                HStack {
                    VStack {
                        HStack{
                            WebImage(url: URL(string: self.homeVM.trendList[0].image) )
                            .resizable()
                            .scaledToFit()
                                .frame(width: ( UIScreen.main.bounds.size.width - 30 )/3 - 12, height: UIScreen.main.bounds.size.height * 0.6/3 - 12)

                            WebImage(url: URL(string: self.homeVM.trendList[1].image) )
                            .resizable()
                            .scaledToFit()
                                .frame(width: ( UIScreen.main.bounds.size.width - 30 )/3 - 12, height: UIScreen.main.bounds.size.height * 0.6/3 - 12)

                        }
                        
                        WebImage(url: URL(string: self.homeVM.trendList[3].image) )
                        .resizable()
                        .scaledToFit()
                            .frame(width: ( 2 * (UIScreen.main.bounds.size.width - 30 )/3 ) - 12, height: UIScreen.main.bounds.size.height * 0.6/3 - 12)
                        
                        
                        
                        HStack{
                            WebImage(url: URL(string: self.homeVM.trendList[4].image) )
                            .resizable()
                            .scaledToFit()
                                .frame(width: ( UIScreen.main.bounds.size.width - 30 )/3 - 12, height: UIScreen.main.bounds.size.height * 0.6/3 - 12)

                            WebImage(url: URL(string: self.homeVM.trendList[5].image) )
                            .resizable()
                            .scaledToFit()
                                .frame(width: ( UIScreen.main.bounds.size.width - 30 )/3 - 12, height: UIScreen.main.bounds.size.height * 0.6/3 - 12)

                        }
                    }
                    
                    
                    WebImage(url: URL(string: self.homeVM.trendList[2].image) )
                    .resizable()
                    .scaledToFit()
                        .frame(width: ( UIScreen.main.bounds.size.width - 30 )/3 - 12, height: UIScreen.main.bounds.size.height * 0.6 - 12)
                }
            }
            
            Rectangle().stroke(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.3)), lineWidth: 1.5)
            
            VStack {
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.3))).frame(width: UIScreen.main.bounds.size.width - 30, height: 1.5)
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.3))).frame(width: UIScreen.main.bounds.size.width - 30, height: 1.5)
                Spacer()
            }
            
            HStack {
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.3))).frame(width: 1.5, height: UIScreen.main.bounds.size.height * 0.6)
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.3))).frame(width: 1.5, height: UIScreen.main.bounds.size.height * 0.6)
                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height * 0.6)
    }
}
