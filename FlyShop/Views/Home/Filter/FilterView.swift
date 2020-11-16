//
//  FilterView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import AlertX

enum ActiveSheet {
    case brand, size, type, arView
}

struct FilterView: View {
    
    @ObservedObject var filterVM = FilterViewModel()
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    @State private var activeSheet: ActiveSheet = .brand
    @State private var goToResult: Bool = false
    
    var body: some View {
        
        ScrollView{
            VStack {
                Section(header: SortSectionHeader()) {
                    VStack {
                        HStack {
                            
                            TextDesign(text: "Նոր", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
                            
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
                            TextDesign(text: "Զեղչված", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
                            
                            
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
                
                Text( "").frame( height: 70)
                
                Section(header: FilterBySectionHeader()) {
                    VStack {
                        
                        // Gender Filter
                        GenderFilter().environmentObject(self.filterVM)
                        
                        Divider()
                        
                        BrandFilter(activeSheet: self.$activeSheet, showSheet: self.$showSheet).environmentObject(self.filterVM)
                        
                        Divider()
                        
                        if self.filterVM.gender != "" {

                            CategoryFilter().environmentObject(self.filterVM)
                            
                            Divider()
                            
                                TypeFilter(activeSheet: self.$activeSheet, showSheet: self.$showSheet).environmentObject(self.filterVM)
                                
                                Divider()
                            
                            // Size filter
                            if self.filterVM.category != "Աքսեսուարներ" {
                                SizeFilter(activeSheet: self.$activeSheet, showSheet: self.$showSheet, showAlert: self.$showAlert)
                                    .environmentObject(self.filterVM)
                            }
                        }
 
                    }
                }
                
                HStack {
                    
                    Text( self.filterVM.price == 0 ? "Գինը" : String(format: "%.0f", self.filterVM.price) )
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.size.width/4)
                    
                    Slider(value: self.$filterVM.price, in: 0...400000, step: 1000)
                }.padding(.bottom, 30)
                
                
                NavigationLink(destination: FilterResult().environmentObject(self.filterVM), isActive: self.$goToResult) {
                    EmptyView()
                }
                                
                Spacer()
                
                TextDesign(text: "Ցուցադրել Արդյունքները", size: 15, font: "Montserrat-ExtraLight", color: Color.white)
                    .frame(width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height/16)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(10)
                    .onTapGesture {
                        // perform search in database to shop filtered items to the user
                        
                        if ( self.filterVM.gender != "" ) && self.filterVM.category != "" {
                            self.filterVM.getFilteredData()
                            self.goToResult = true
                        } else {
                            self.showAlert.toggle()
                        }
                        
                }
                
            }.padding()
        }
        .sheet(isPresented: self.$showSheet, content: {
            if self.activeSheet == .size {
                SizeChart(showSheet: self.$showSheet, gender: self.filterVM.gender, category: self.filterVM.category, type: self.filterVM.type)
                        .environmentObject(self.filterVM)
            } else if self.activeSheet == .brand {
                BrandSheet( showSheet: self.$showSheet).environmentObject(self.filterVM)
            } else if self.activeSheet == .type {
                TypeSheet(showSheet: self.$showSheet, typeArray: FilterTypeModel().categoryType(category: self.filterVM.category, gender: self.filterVM.gender))
                    .environmentObject(self.filterVM)
            }
        }).alertX(isPresented: self.$showAlert, content: {
                AlertX(title: Text( "Սխալ" ), message: Text( "Դուք չեք ընտրել սեռը/կատեգորիա/տեսակը" ), primaryButton: .default(Text( "Լավ" )), theme: .graphite(withTransparency: true, roundedCorners: true ), animation: .classicEffect())
            })
            .navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
                // perform the action here
                self.filterVM.checkedSale = false
                self.filterVM.checkedNew = false
                self.filterVM.gender = ""
                self.filterVM.category = ""
                self.filterVM.size = [String]()
                self.filterVM.brand = ""
                self.filterVM.type = ""
            }, label: {
                
                TextDesign(text: "Մաքրել", size: 18, font: "Montserrat-ExtraLight", color: Color.white)
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
            
            TextDesign(text: "Դասավորել ըստ", size: 11, font: "Montserrat-ExtraLight", color: Color.gray)
            
            Spacer()
        }
        
    }
}


struct FilterBySectionHeader: View {
    var body: some View {
        HStack {
            
            TextDesign(text: "Զտել ըստ", size: 11, font: "Montserrat-ExtraLight", color: Color.gray)
            
            Spacer()
        }
    }
}
