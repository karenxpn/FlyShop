//
//  HomeView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeVM = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                HomeViewBackground()
                
                VStack {
                    
                    Header()
                    
                    Spacer()
                    
                    
                    TrendGrid()
                    
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
                    .padding(.vertical, 12)
                    .onTapGesture {
                        self.homeVM.category = self.categoryNames[index]
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
    var body: some View {
        
        ZStack {
            Rectangle().stroke(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.4)), lineWidth: 1.5)
            
            VStack {
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.4))).frame(width: UIScreen.main.bounds.size.width - 60, height: 1.5)
                Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.4))).frame(width: UIScreen.main.bounds.size.width - 60, height: 1.5)
                Spacer()
            }
            
            HStack {
                 Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.4))).frame(width: 1.5, height: UIScreen.main.bounds.size.height * 0.6)
                 Spacer()
                Rectangle().fill(Color( UIColor(red: 108/255, green: 123/255, blue: 138/255, alpha: 0.4))).frame(width: 1.5, height: UIScreen.main.bounds.size.height * 0.6)
                 Spacer()
             }
        }.frame(width: UIScreen.main.bounds.size.width - 60, height: UIScreen.main.bounds.size.height * 0.6)
    }
}
