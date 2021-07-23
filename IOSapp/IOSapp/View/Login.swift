//
//  Login.swift
//  IOSapp
//
//  Created by TarraeRarae on 22.07.2021.
//

import SwiftUI

struct Login: View {
    @State private var email : String = ""
    @State private var password : String = ""
    @Binding private var isLogged : Bool
    @Binding private var usr : User
    @Binding private var isProfileAccessToRun : Bool
    @State private var loggedInUser : User? = nil
    @State private var nextView : Int? = 0
    @State private var isValidData = true
    var body: some View {
            VStack {
                Text("Авторизация")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .kerning(1.9)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Введен неверный Email или пароль")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .disabled(true)
                        .hidden()
                    Text("Email")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("example@email.com", text: $email)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top, 5)
                        .disableAutocorrection(true)
                        .textContentType(.emailAddress)
                        .textCase(.lowercase)
                        .autocapitalization(.none)

                    Divider()
                })
                .padding(.top, 25)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Пароль")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    SecureField("пароль", text: $password)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top, 5)
                        .autocapitalization(.none)
                    Divider()
                })
                .padding(.top, 20)
                Spacer()
                Text("Введены неправильный Email или пароль")
                    .foregroundColor(isValidData ? Color.white : Color.red)
                    .font(.body)
                    .padding()
                    .frame(alignment: .leading)
                Spacer()
                
                Button(action: {
                    if isValidEmail() && isValidPassword() {
                        login()
                        isValidData = true
                        if loggedInUser != nil {
                            usr = loggedInUser ?? User(login: "-", password: "-", name: "-", surname: "-")
                            holdData()
                            isProfileAccessToRun = true
                            isValidData = true
                            isLogged = true
                        }
                    } else {
                       
                        isValidData = false
                    }
                }, label: {
                    VStack {
                       
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24, weight: .bold ))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(color: .black, radius: 5)
                      
                        }
                    })
                .padding(.top, 20)
                Spacer()
            }
            .padding()
        }
    
    func login() {
        loggedInUser = User.login(login: email, password: password)
    }
    
    func holdData() {
        UserDefaults.standard.set(true, forKey: "logged")
        UserDefaults.standard.set(usr.login, forKey: "usrLogin")
        UserDefaults.standard.set(usr.password, forKey: "usrPassword")
    }
    
    func isValidEmail() -> Bool {
            let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: email)
            return result
        }
    
    
    
    
    // Need to be improved
    // Too much lets
    // We can make 6 rows of function
    
    func isValidPassword() -> Bool {
        
        let sizeOfPass = password.count >= 6 ? true : false
        
        let lowerCase = ".*[A-Z]+.*"
        let testLowerCase = NSPredicate(format: "SELF MATCHES %@", lowerCase)
        let isContainLowerCase = testLowerCase.evaluate(with: password)

        let upperCase = ".*[a-z]+.*"
        let testUpperCase = NSPredicate(format: "SELF MATCHES %@", upperCase)
        let isContainUpperCase = testUpperCase.evaluate(with: password)
        
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: password)
        
        let result = isContainUpperCase && containsNumber && sizeOfPass && isContainLowerCase
        
        return result
    }
}
