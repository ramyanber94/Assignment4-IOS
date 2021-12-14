//
//  ApiServiceController.swift
//  FlightApp
//
//  Created by user202286 on 12/1/21.
//

import Foundation

class ApiServiceController {
    
    static var shared = ApiServiceController()
    
    func getAllLeagues(handler: @escaping ([match])-> Void){
        let urlString = "https://api.football-data-api.com/league-matches?key=test85g57&season_id=2012"
        let urlObj = URL(string: urlString)!
        URLSession.shared.dataTask(with: urlObj) { (data , apiresponse , error) in
            if let error = error{
                print(error)
            }
            else if let correct_data = data{
                do {
                    let decoder = JSONDecoder()
                    let resultFromDecoder = try? decoder.decode(result.self ,from: correct_data)
                    handler(resultFromDecoder!.data)
                }
            }
        }.resume()
    }
  
}
