//
//  ReturnPolicy.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct ReturnPolicy: View {
    var body: some View {
        ZStack {
            AllShopsBackground()
            
            VStack {
                ScrollView {
                    Text("Եթե գոհ չեք ձեր գնումից, մենք 14 օրվա ընթացքում կընդունենք չօգտագործված արտադրանքի վերադարձը: Վերադարձված ապրանքը ստանալուց հետո FlyShop- ը կտրամադրի ամբողջ գումարը:\n\nԶեղչված իրերը իրավասու են վերադարձի համար:\n\nFlyShop- ը չի տրամադրի փոխհատուցումներ այլ սուբյեկտների միջոցով ձեռք բերված ապրանքների համար, ինչպիսիք են դիստրիբյուտորները կամ մանրածախ գործընկերները:\n\nՎերադարձված իրերը պետք է մեզ առաքվեն չօգտագործված, նախնական փաթեթավորման մեջ և ստացված վիճակում: Մենք չենք կարող պատասխանատվություն կրել վնասված կամ կորած իրերի համար:\n\nԿան իրեր, որոնք իրավասու չեն վերադարձ i (hayeren tar)\n\nՄենք ի վիճակի չենք փոխհատուցում տրամադրել առանց առարկայի (ներ) ի ev(hayaren tar)  փաստացի ստացման վերադարձի ապացույցների:\n\nՄենք նպատակ ունենք ընդունել բոլոր վերադարձները: Անհավատալի դեպքում, երբ որևէ առարկա վերադառնա մեզ ոչ պիտանի վիճակում, գուցե մենք ստիպված լինենք այն ուղարկել ձեզ: Վերադարձի ընթացքում ստուգվելու են բոլոր ապրանքները:")
                        .padding(.top, 12)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 12)
                }
            }
        }.navigationBarTitle(Text( "Վերադարձի Քաղաքականություն" ), displayMode: .inline)
    }
}

struct ReturnPolicy_Previews: PreviewProvider {
    static var previews: some View {
        ReturnPolicy()
    }
}