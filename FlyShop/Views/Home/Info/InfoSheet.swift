//
//  InfoSheet.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI


struct InfoSheet: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                AllShopsBackground()
                
                ScrollView {
                    
                    VStack( spacing: 20 ) {
                        NavigationLink(destination: AboutUs()) {
                            
                            VStack {
                                Text( "Մեր Մասին" )
                                    .padding(.top, 8)
                                    .foregroundColor(Color.black)
                                
                                Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                                
                                Image("aboutus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3)
                                
                            }.background(Color.white)
                                .cornerRadius(20)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ReturnPolicy()) {
                            VStack {
                                Text( "Վերադարձի Քաղաքականություն" )
                                    .padding(.top, 8)
                                    .foregroundColor(Color.black)
                                
                                Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                                
                                Image("return")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3)
                                
                            }.background(Color.white)
                                .cornerRadius(20)
                        }.buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: Shipping()) {
                            VStack {
                                Text( "Առաքման Եղանակը" )
                                    .padding(.top, 8)
                                    .foregroundColor(Color.black)
                                
                                Divider().frame(width: UIScreen.main.bounds.size.width/2 - 40 )
                                
                                Image("shipping")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3)
                                
                            }.background(Color.white)
                                .cornerRadius(20)
                        }.buttonStyle(PlainButtonStyle())
                        
                        
                        Text( "Կոնտակտներ: +374(33)-988-988\n\nflyshopcompany@gmail.com")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .font(.system(size: 17))
                        
                        
                    }.padding()
                    
                }
                .navigationBarTitle(Text( "Info" ), displayMode: .inline)
            }
        }
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet()
    }
}
