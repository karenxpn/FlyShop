//
//  SignUp.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import AlertX

struct SignUp: View {
    
    //Keyboard
    @State var value: CGFloat = 0
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack{
            
            Background()
            VStack( spacing: 20) {
                Image( "flyshoplogo" )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width/1.5, height: UIScreen.main.bounds.size.height/3.5)
                
                Text( "FlyShop" )
                    .font(.custom("McLaren-Regular", size: 45))
                
                NumberInput()
                
                VStack {
                    
                    TextField( "Հաստատման կոդ", text: self.$authVM.confirmationCode)
                        .padding([.top, .bottom], 14)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color.white)
                        .font( .custom("Montserrat-Light", size: 16)).multilineTextAlignment(.center)
                    
                }.padding([.leading, .trailing], 12)
                    .background(
                        Image("signUpTextFieldBg")
                            .resizable()
                            .aspectRatio(contentMode: .fill))
                    .cornerRadius(8)
                
                VStack {
                    Text( "Գրանցվել")
                        .foregroundColor(Color.white)
                        .font( .custom("Montserrat-Light", size: 20))
                    
                }.padding([.top, .bottom], 11)
                    .frame(width: UIScreen.main.bounds.size.width-30)
                    .background(
                        Image("signUpButtonBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill))
                    .cornerRadius(20)
                    .onTapGesture {
                        if self.authVM.number != "" && self.authVM.confirmationCode != "" {
                            self.authVM.logTheUser()
                        } else {
                            self.authVM.showAlert = true
                        }
                }
                
                
                Text( "Ձեր ընտրությունը" )
                    .foregroundColor(Color.white)
                    .font( .custom("Montserrat-Light", size: 14))
                    .padding()
                
                Text( "Մեր հոգսն է" )
                    .foregroundColor(Color.white)
                    .font( .custom("Montserrat-Light", size: 20))
                    .padding(6)
                
                
            }.padding()
                .offset( y: -self.value )
                .animation(.spring())
                .onAppear {
                    self.keyboardNotification()
            }
            
            if self.authVM.showLoading {
                Loading()
            }
        }.alertX(isPresented: self.$authVM.showAlert, content: {
            AlertX(title: Text( "Սխալ" ), message: Text( "Մուտքագրեք հեռախոսահամարը և հաստատման կոդը" ), primaryButton: .default(Text( "Լավ" )), theme: .graphite(withTransparency: true, roundedCorners: true ), animation: .classicEffect())

        }) .onTapGesture {
                UIApplication.shared.endEditing()
        }
    }
    
    func keyboardNotification() {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
            
            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = value.height
            
            self.value = height + 30
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            
            self.value = 0
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

struct NumberInput: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        HStack{
            Text( "+374" )
                .font( .custom("Montserrat-Italic", size: 35))
                .foregroundColor(Color.white)
            
            Image( "cursor" )
                .resizable()
                .frame(width: 2, height: 35)
            
            TextField("", text: self.$authVM.number)
                .keyboardType(.numberPad)
                .foregroundColor(Color.white)
                .font( .custom("Montserrat-Italic", size: 35))
                .frame( height: 35)
            
            Image( "signUpNumberAttr" )
                .resizable()
                .frame(width: 35, height: 35)
                // send verification code
                .onTapGesture {
                    self.authVM.signUp()
            }
            
            Spacer()
        }.padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 5)
            .background(
                Image("signUpTextFieldBg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
        ).cornerRadius(8)
    }
}


