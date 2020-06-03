//
//  AboutUs.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        
        ZStack {
            AllShopsBackground()
            
            VStack {
                ScrollView {
                    Text("Բարի գալուստ FlyShop ՝ ձեր համարի մեկ հարթակ բոլոր խանութների համար: Մենք նվիրված ենք ձեզ ՝ լավագույնս ապահովելու համար, հուսալիության շեշտը դնելով: Հաճախորդների սպասարկում և առցանց գնումներ:\n\nՄենք աշխատում ենք վերածվել բուռն առցանց խանութի: Հուսով ենք, որ դուք կվայելեք մեր պլատֆորմը այնքանով, որքանով հաճույք ենք ստանում դրանք ձեզ առաջարկելուց:\n\nՁեր ընտրությունը - Մեր հոքսն է\nՀարգանքներով ՝ FlyShop")
                        .foregroundColor(Color.white)
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                }
            }
        }.navigationBarTitle(Text( "Մեր Մասին" ), displayMode: .inline)
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
