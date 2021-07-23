//
//  Profile.swift
//  IOSapp
//
//  Created by TarraeRarae on 22.07.2021.
//

import SwiftUI

struct Profile: View {
    @Binding private var usr : User
    @Binding private var isLogged : Bool
    var body: some View {
        VStack {
            Spacer()
            Text("Профиль")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            Spacer()
            HStack {
                Image("\(usr.login)")
                    .resizable()
                    .frame(maxWidth: 150,  maxHeight: 150, alignment: .leading)
                VStack {
                    Text(usr.login)
                    HStack {
                        Text(usr.name)
                        Text(usr.surname)
                    }
                }
            }
            Spacer()
            Button(action: {
                UserDefaults.standard.setValue(false, forKey: "logged")
                UserDefaults.standard.setValue("", forKey: "usrLogin")
                UserDefaults.standard.setValue("", forKey: "password")
                isLogged = false
                
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 24, weight: .bold ))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 5)
            })
            .padding(.top, 20)
            Spacer()
        }
                
    }
}


