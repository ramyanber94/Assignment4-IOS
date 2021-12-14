//
//  Team.swift
//  FlightApp
//
//  Created by user202286 on 12/9/21.
//

import Foundation

struct teamsresult : Codable {
    var items : [teams]
}

struct teams : Codable {
    var id : Int
    var name : String
    var league : Int
}
