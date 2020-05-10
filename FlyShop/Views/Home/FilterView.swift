//
//  FilterView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @State private var showAler: Bool = false
    @ObservedObject var filterVM = FilterViewModel()
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        
        VStack {
            Section(header: SortSectionHeader()) {
                VStack {
                    HStack {
                        Text( "NEWEST")
                            .font( .custom("Montserrat-Italic", size: 14))
                        
                        Spacer()
                        
                        Image( self.filterVM.checkedNew ? "checked" : "unchecked")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }.onTapGesture {
                        self.filterVM.checkedNew.toggle()
                        if self.filterVM.checkedSale {
                            self.filterVM.checkedSale.toggle()
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text( "SALES" )
                            .font( .custom("Montserrat-Italic", size: 14))
                        
                        
                        Spacer()
                        
                        Image( self.filterVM.checkedSale ? "checked" : "unchecked")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }.onTapGesture {
                        self.filterVM.checkedSale.toggle()
                        if self.filterVM.checkedNew {
                            self.filterVM.checkedNew.toggle()
                        }
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
                                if self.filterVM.maleGender {
                                    self.filterVM.maleGender.toggle()
                                }
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
                                if self.filterVM.femaleGender {
                                    self.filterVM.femaleGender.toggle()
                                }
                        }
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Text( "CATEGORY" )
                            .font( .custom("Montserrat-Italic", size: 14))
                        
                        
                        Spacer()
                        
                        Text( "Clothes" )
                            .font( .custom("Montserrat-Italic", size: 12))
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom], 8)
                            .padding([.horizontal], 12)
                            .background( self.filterVM.clothes ? Color.blue : Color.gray)
                            .cornerRadius(20)
                            .onTapGesture {
                                self.filterVM.size = [String]()
                                self.filterVM.clothes.toggle()
                                if self.filterVM.shoes {
                                    self.filterVM.shoes.toggle()
                                }
                                if self.filterVM.accessories {
                                    self.filterVM.accessories.toggle()
                                }
                        }
                        
                        Text( "Shoes" )
                            .font( .custom("Montserrat-Italic", size: 12))
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom], 8)
                            .padding([.horizontal], 12)
                            .background(self.filterVM.shoes ? Color.blue : Color.gray)
                            .cornerRadius(20)
                            .onTapGesture {
                                self.filterVM.size = [String]()
                                self.filterVM.shoes.toggle()
                                if self.filterVM.clothes {
                                    self.filterVM.clothes.toggle()
                                }
                                if self.filterVM.accessories {
                                    self.filterVM.accessories.toggle()
                                }
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
                                if self.filterVM.shoes {
                                    self.filterVM.shoes.toggle()
                                }
                                if self.filterVM.clothes {
                                    self.filterVM.clothes.toggle()
                                }
                        }
                        
                    }.padding([.bottom, .top], 6)
                    
                    Divider()
                    
                    
                    if self.filterVM.accessories == false {
                        HStack {
                            Text( "SIZE" )
                                .font( .custom("Montserrat-Italic", size: 14))
                            
                            
                            Spacer()
                            
                            HStack {
                                Text( self.filterVM.size.isEmpty ? "Your size" : self.getSizes() )
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
                                    .onTapGesture {
                                        if self.filterVM.maleGender || self.filterVM.femaleGender {
                                            if self.filterVM.shoes || self.filterVM.clothes {
                                                self.showSheet = true
                                            } else {
                                                self.showAler.toggle()
                                            }
                                        }
                                        else {
                                            self.showAler.toggle()
                                        }
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text( "PRICE" )
                            .font( .custom("Montserrat-Italic", size: 14))               
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
                    print(self.filterVM.size)
                    
            }
            
        }.padding()
            .sheet(isPresented: self.$showSheet, content: {
                if self.filterVM.maleGender {
                    if self.filterVM.shoes {
                        SizeChart(showSheet: self.$showSheet, gender: "Male", category: "Shoes")
                            .environmentObject(self.filterVM)
                    } else if self.filterVM.clothes {
                        SizeChart(showSheet: self.$showSheet,gender: "Male", category: "Clothes")
                            .environmentObject(self.filterVM)
                    }
                } else {
                    if self.filterVM.shoes {
                        SizeChart(showSheet: self.$showSheet,gender: "Male", category: "Shoes")
                            .environmentObject(self.filterVM)
                    } else if self.filterVM.clothes {
                        SizeChart(showSheet: self.$showSheet,gender: "Male", category: "Clothes")
                            .environmentObject(self.filterVM)
                    }
                }
            })
            .alert(isPresented: self.$showAler, content: {
                Alert(title: Text( "Error"), message: Text( "You haven't selected gender or category"), dismissButton: .default(Text( "OK" )))
            })
            .navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
                // perform the action here
                self.filterVM.checkedSale = false
                self.filterVM.checkedNew = false
                self.filterVM.maleGender = false
                self.filterVM.femaleGender = false
                self.filterVM.shoes = false
                self.filterVM.clothes = false
                self.filterVM.accessories = false
                self.filterVM.size = [String]()
                self.filterVM.price = 0
            }, label: {
                Text( "Clear" )
                    .font( .custom("Montserrat-Italic", size: 16))
                    .foregroundColor(Color.white)
            }))
        
    }
    
    func getSizes() -> String {
        var sizeString = ""
        for i in 0..<self.filterVM.size.count {
            if i != self.filterVM.size.count-1 {
                sizeString += self.filterVM.size[i] + ","
            } else {
                sizeString += self.filterVM.size[i]
            }
        }
        return sizeString
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

