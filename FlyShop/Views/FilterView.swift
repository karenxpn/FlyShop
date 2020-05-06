//
//  FilterView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var filterVM = FilterViewModel()
    
    var body: some View {
        ZStack {
            FilterBackground()
            
            VStack {
                Section(header: SortSectionHeader()) {
                    VStack {
                        HStack {
                            Text( "NEWEST")
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Image( self.filterVM.checkedNew ? "checked" : "unchecked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }.onTapGesture {
                            self.filterVM.checkedNew.toggle()
                        }
                        
                        Divider()
                        
                        HStack {
                            Text( "SALES" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            
                            Spacer()
                            
                            Image( self.filterVM.checkedSale ? "checked" : "unchecked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }.onTapGesture {
                            self.filterVM.checkedSale.toggle()
                        }
                        
                        Divider()
                    }
                }
                
                Text( "" ).frame(height: 70)
                
                Section(header: FilterBySectionHeader()) {
                    VStack {
                        HStack {
                            Text( "GENDER" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            
                            Spacer()
                            
                            ZStack {
                                
                                Circle().fill( self.filterVM.femaleGender ? Color.blue : Color.gray).frame(width: 40, height: 40)
                                
                                Image( "womenGender" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }.padding(2)
                                .onTapGesture {
                                    self.filterVM.femaleGender.toggle()
                            }
                            
                            ZStack {
                                
                                Circle().fill(self.filterVM.maleGender ? Color.blue : Color.gray).frame(width: 40, height: 40)
                                
                                Image( "manGender" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }.padding(2)
                                .onTapGesture {
                                    self.filterVM.maleGender.toggle()
                            }
                            
                        }
                        
                        Divider()
                        
                        HStack {
                            Text( "CATEGORY" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            
                            Spacer()
                            
                            Text( "Clothes" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background( self.filterVM.clothes ? Color.blue : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.filterVM.clothes.toggle()
                            }
                            
                            Text( "Shoes" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background(self.filterVM.shoes ? Color.blue : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.filterVM.shoes.toggle()
                            }
                            
                            Text( "Accessories" )
                                .font( .custom("Montserrat-Italic", size: 12))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 8)
                                .padding([.horizontal], 12)
                                .background(self.filterVM.accessories ? Color.blue : Color.gray)
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.filterVM.accessories.toggle()
                            }
                            
                        }.padding([.bottom, .top], 6)
                        
                        Divider()
                        
                        HStack {
                            Text( "SIZE" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            
                            Spacer()
                            
                            HStack {
                                Text( "Your size" )
                                    .font( .custom("Montserrat-Italic", size: 14))
                                    .foregroundColor(Color.white)
                                    .padding([.top, .bottom], 6)
                                    .padding([.trailing, .leading], 12)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                
                                Text( "+" )
                                    .font( .custom("Montserrat-Italic", size: 20))
                                    .foregroundColor(Color.white)
                                    .padding([.leading, .trailing], 12)
                                    .padding([.top, .bottom], 6)
                                    .background(Color.blue)
                                    .cornerRadius(30)
                                
                                
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text( "PRICE" )
                                .font( .custom("Montserrat-Italic", size: 14))
                                .foregroundColor(Color.white)
                            
                            
                            Spacer()
                            
                            Slider(value: self.$filterVM.price, in: 0...800000, step: 500)
                                .accentColor(Color.red)
                            
                        }
                    }
                }
                
                Spacer()
                
                Text( "SHOW RESULTS" )
                    .font( .custom("Montserrat-Italic", size: 16))
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height/16)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        // perform search in database to shop filtered items to the user
                }
                
            }.padding()
            
        }  .navigationBarTitle(Text( "Products"))
            .navigationBarItems(trailing: Button(action: {
                // perform the action here
            }, label: {
                Text( "Clear" )
                    .font( .custom("Montserrat-Italic", size: 16))
                    .foregroundColor(Color.white)
            }))
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

struct SortSectionHeader : View {
    var body: some View {
        
        HStack {
            Text( "SORT BY" )
                .font( .custom("Montserrat-Italic", size: 12))
                .foregroundColor(Color.gray)
            Spacer()
        }
        
    }
}


struct FilterBySectionHeader: View {
    var body: some View {
        HStack {
            Text( "FILTER BY" )
                .font( .custom("Montserrat-Italic", size: 12))
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}


