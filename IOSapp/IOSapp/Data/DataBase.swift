//
//  DataBase.swift
//  IOSapp
//
//  Created by TarraeRarae on 22.07.2021.
//

import Foundation


struct User {

    let login: String
    let password: String
    let name : String
    let surname: String
    
    static func login(login:String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(login: "user1@mail.ru", password: "Password1", name : "Andrey", surname: "Andreev"),
            User(login: "user2@mail.ru", password: "Password2",name : "Nikolai", surname: "Nikolaev"),
            User(login: "user3@mail.ru", password: "Password3",name : "Alexey", surname: "Alexeev"),
            User(login: "user4@mail.ru", password: "Password4",name : "Ivan", surname: "Ivanovich"),
            ] {
                theDatabase[user.login] = user
        }
       return theDatabase
    }()
    
}
