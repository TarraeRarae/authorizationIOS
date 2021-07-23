//
//  ContentView.swift
//  IOSapp
//
//  Created by TarraeRarae on 22.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isProfileRunning : Bool = false
    @State private var user : User = User(login: "-", password: "-", name: "-", surname: "-")
    
    @State private var isLogged : Bool = UserDefaults.standard.bool(forKey: "logged")
    @State private var usrLogin : String = UserDefaults.standard.string(forKey: "usrLogin") ?? ""
    @State private var usrPassword : String = UserDefaults.standard.string(forKey: "usrPassword") ?? ""
    
    var body: some View {
            ZStack {
                if isLogged && !isProfileRunning {
                    if usrLogin.count > 2 {
                        Group {
                            VStack {
                                Spacer()
                                    Text("Вы не вышли из своего аккаунта")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.center)
                                        
                                    Spacer()
                                Group {
                                    VStack {
                                            Spacer()
                                            Button(action: {
                                                login()
                                                isProfileRunning = true
                                            }, label: {
                                                Text("Продолжить сеанс")
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .background(Color.black)
                                                    .shadow(color: .black, radius: 5)
                                            })
                                            Spacer()
                                            Button(action: {
                                                isLogged = false
                                            }, label: {
                                                Text("Выйти из аккаунта")
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .background(Color.black)
                                                    .shadow(color: .black, radius: 5)
                                                       
                                            })
                                            Spacer()
                                    }
                                    Spacer()
                                }

                            }
                        }
                    }
                }
                
                if isLogged && isProfileRunning {
                    Profile(usr: $user, isLogged: $isLogged)
                        .transition(.move(edge: .bottom))
                } else if !isLogged {
                    Login(isLogged: $isLogged, usr: $user, isProfileAccessToRun: $isProfileRunning)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    
    func login() {
        user = User.login(login: usrLogin , password: usrPassword) ?? User(login: "-", password: "-", name: "-", surname: "-")
    }
    
}
