//
//  SuccessUserManager.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import Foundation

class SuccessUserManager {
    var user = [SuccessUser]()
        
        func addSuccessUsers(u : SuccessUser){
            user.append(u)
        }
        
        func getAllImages()->[SuccessUser]{
           return user
       }
}
