//
//  Flights.swift
//  FlightApp
//
//  Created by user202286 on 12/1/21.
//

import Foundation

struct result : Codable {
    var data : [match]
}

struct match : Codable {
    var id : Int
    var homeGoalCount : Int
    var awayGoalCount : Int
    var home_image : String
    var away_image : String
    var home_name : String
    var away_name : String
}


