//
//  FlightsViewCell.swift
//  FlightApp
//
//  Created by user202286 on 12/1/21.
//

import UIKit

class FutViewCell: UITableViewCell {

    @IBOutlet weak var imgAwayTeam: UIImageView!
    @IBOutlet weak var lblAwayTeamScore: UILabel!
    @IBOutlet weak var lblAwayTeamName: UILabel!
    @IBOutlet weak var lblHomeTeamScore: UILabel!
    @IBOutlet weak var lblHomeTeamName: UILabel!
    @IBOutlet weak var imgHomeTeam: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codessdddds
    }
   
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
