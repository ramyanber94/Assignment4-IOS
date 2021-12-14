//
//  SuccessUser.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import Foundation

struct SuccessUser{
    
    var first_name : String
    var last_name : String
    var user_name : String
    var password : String
    
    init(f: String, l: String , u: String , p: String) {
        first_name = f
        last_name = l
        user_name = u
        password = p
    }
}
