//
//  FilterView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case brand, size, accessories, arView
}

struct FilterView: View {
    
    @State private var showAler: Bool = false
    @ObservedObject var filterVM = FilterViewModel()
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
                        HStack {
                            
                            TextDesign(text: "Սեռը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
                            
                            Spacer()
                            
                            ZStack {
                                
                                Circle().fill( self.filterVM.femaleGender ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray).frame(width: 40, height: 40)
                                
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
                                
                                Circle().fill(self.filterVM.maleGender ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray).frame(width: 40, height: 40)
                                
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
                        
                        BrandFilter(activeSheet: self.$activeSheet, showSheet: self.$showSheet).environmentObject(self.filterVM)
                        
                        Divider()
                        
                        CategoryFilter().environmentObject(self.filterVM)
                        
                        Divider()
                        
                        
                        TypeFilter(activeSheet: self.$activeSheet, showSheet: self.$showSheet).environmentObject(self.filterVM)
                        
                        Divider()
                        
                        // Size filter
                        if self.filterVM.category != "Աքսեսուարներ" {
                            HStack {
                                TextDesign(text: "Չափը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
                                
                                
                                
                                Spacer()
                                
                                HStack {
                                    
                                    TextDesign(text: self.filterVM.size.isEmpty ? "Ձեր չափը" : self.getSizes(), size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                                        .padding([.top, .bottom], 6)
                                        .padding([.trailing, .leading], 12)
                                        .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                                        .cornerRadius(20)
                                    
                                    TextDesign(text: "+", size: 20, font: "Montserrat-ExtraLight", color: Color.white)
                                        .padding([.leading, .trailing], 12)
                                        .padding([.top, .bottom], 6)
                                        .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                                        .cornerRadius(30)
                                        .onTapGesture {
                                            if ( self.filterVM.maleGender || self.filterVM.femaleGender ) && ( self.filterVM.category == "Հագուստ" || self.filterVM.category == "Կոշիկ" ) && self.filterVM.type != "" {
                                                self.activeSheet = .size
                                                self.showSheet = true
                                            }
                                            else {
                                                self.showAler.toggle()
                                            }
                                    }
                                    
                                    
                                }
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
                
                HStack {
                    
                    Spacer()
                
                    TextDesign(text: "AR\nԱպրանքներ", size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .cornerRadius(30)
                        .onTapGesture {
                            // Show AR products in result screen
                            
                    }
                }.padding(.trailing, 15)
                
                Text( "").frame( height: 30)

                
                Spacer()
                
                TextDesign(text: "Ցուցադրել Արդյունքները", size: 15, font: "Montserrat-ExtraLight", color: Color.white)
                    .frame(width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height/16)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(10)
                    .onTapGesture {
                        // perform search in database to shop filtered items to the user
                        
                        if ( self.filterVM.femaleGender || self.filterVM.maleGender ) && self.filterVM.category != "" && self.filterVM.type != "" {
                            self.filterVM.getFilteredData()
                            self.goToResult = true
                        } else {
                            self.showAler.toggle()
                        }
                        
                }
                
            }.padding()
        }
        .sheet(isPresented: self.$showSheet, content: {
            if self.activeSheet == .size {
                if self.filterVM.maleGender {
                    SizeChart(showSheet: self.$showSheet, gender: "Տղամարդու", category: self.filterVM.category, type: self.filterVM.type)
                        .environmentObject(self.filterVM)
                    
                } else {
                    SizeChart(showSheet: self.$showSheet,gender: "Իգական", category: self.filterVM.category, type: self.filterVM.type)
                        .environmentObject(self.filterVM)
                }
            } else if self.activeSheet == .brand {
                BrandSheet( showSheet: self.$showSheet).environmentObject(self.filterVM)
            } else if self.activeSheet == .accessories {
                AccessoriesSheet(showSheet: self.$showSheet, typeArray: FilterTypeModel().categoryType(category: self.filterVM.category))
                    .environmentObject(self.filterVM)
            }
        })
            .alert(isPresented: self.$showAler, content: {
                Alert(title: Text( "Սխալ"), message: Text( "Դուք չեք ընտրել սեռը/կատեգորիա/տեսակը"), dismissButton: .default(Text( "Լավ" )))
            })
            .navigationBarTitleView( NavigationTitleView(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
                // perform the action here
                self.filterVM.checkedSale = false
                self.filterVM.checkedNew = false
                self.filterVM.maleGender = false
                self.filterVM.femaleGender = false
                self.filterVM.category = ""
                self.filterVM.size = [String]()
                self.filterVM.brand = ""
                self.filterVM.type = ""
            }, label: {
                
                TextDesign(text: "Մաքրել", size: 18, font: "Montserrat-ExtraLight", color: Color.white)
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


struct CategoryFilter: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    var body: some View {
        // CategoryFilter
        HStack {
            
            TextDesign(text: "Կատեգորիա", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            
            Spacer()
            
            ForEach(FilterTypeModel().categories(), id: \.self) { category in
                
                TextDesign(text: category, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.top, .bottom], 8)
                    .padding([.horizontal], 10)
                .lineLimit(1)
                    .background( self.filterVM.category == category ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray)
                    .cornerRadius(20)
                    .onTapGesture {
                        self.filterVM.type = ""
                        self.filterVM.category = category
                }
                
            }
            
        }.padding([.bottom, .top], 6)
    }
}

struct BrandFilter: View {
    
    @EnvironmentObject var filterVM: FilterViewModel
    @Binding var activeSheet: ActiveSheet
    @Binding var showSheet: Bool
    
    var body: some View {
        // Brand Filter
        HStack {
            
            TextDesign(text: "Ապրանքանիշը", size: 14, font: "Montserrat-ExtraLight", color: Color.black)
            
            Spacer()
            
            HStack {
                
                TextDesign(text:  self.filterVM.brand == "" ? "Ընտրեք ապրանքանիշը" : self.filterVM.brand, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.top, .bottom], 6)
                    .padding([.trailing, .leading], 12)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(20)
                
                TextDesign(text: "+", size: 20, font: "Montserrat-ExtraLight", color: Color.white)
                    .padding([.leading, .trailing], 12)
                    .padding([.top, .bottom], 6)
                    .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                    .cornerRadius(30)
                    .onTapGesture {
                        self.activeSheet = .brand
                        self.showSheet.toggle()
                        
                }
            }
        }
    }
}

struct TypeFilter: View {
    
    @EnvironmentObject var filterVM : FilterViewModel
    @Binding var activeSheet: ActiveSheet
    @Binding var showSheet: Bool
    
    var body: some View {
        // Type Filter
        
        HStack {
            
            TextDesign(text: "Տիպ", size: 13, font: "Montserrat-ExtraLight", color: Color.black)
            
            
            Spacer()
            
            
            ForEach( FilterTypeModel().categoryType(category: self.filterVM.category), id: \.self) { type in
                if self.filterVM.category != "Աքսեսուարներ" {
                    
                    TextDesign(text: type, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                        .padding([.top, .bottom], 8)
                        .padding([.horizontal], 12)
                        .background( self.filterVM.type == type ? Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)) : Color.gray)
                        .cornerRadius(20)
                        .onTapGesture {
                            self.filterVM.type = type
                    }
                }
            }
            
            if self.filterVM.category == "Աքսեսուարներ" {
                HStack {
                    
                    TextDesign(text: self.filterVM.type == "" ? "Ընտրեք տեսակը" : self.filterVM.type, size: 14, font: "Montserrat-ExtraLight", color: Color.white)
                        .padding([.top, .bottom], 6)
                        .padding([.trailing, .leading], 12)
                        .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                        .cornerRadius(20)
                    
                    TextDesign(text: "+", size: 20, font: "Montserrat-ExtraLight", color: Color.white)
                        .padding([.leading, .trailing], 12)
                        .padding([.top, .bottom], 6)
                        .background(Color(UIColor(red: 90/255, green: 123/255, blue: 239/255, alpha: 1)))
                        .cornerRadius(30)
                        .onTapGesture {
                            self.activeSheet = .accessories
                            self.showSheet.toggle()
                            
                    }
                }
            }
        }
    }
}
