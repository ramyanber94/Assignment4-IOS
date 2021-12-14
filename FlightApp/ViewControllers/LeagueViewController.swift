//
//  SearchFlightsController.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate{
    var successUser : User?
    var results : [match]?
    var filterResult : [match]?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMatches: UITableView!
    @IBOutlet weak var lblWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = successUser?.firstname{
            lblWelcome.text = "Welcome \(name)"
        }
        ApiServiceController.shared.getAllLeagues { (resultsFromApi) in
            DispatchQueue.main.async {
                self.results = resultsFromApi
                self.filterResult = self.results
                self.tblMatches.reloadData()
            }
        }
        searchBar.delegate = self
        
    }
    @IBAction func btnFav(_ sender: Any) {
        self.performSegue(withIdentifier: "displayFav", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayFav" {
            let SVC = segue.destination as! FavoritesViewController
            SVC.favorites = successUser?.favorites?.allObjects as? [Favorites]
            SVC.username = successUser?.username
        }
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func showConfirmation(){
        let alertController = UIAlertController(title: "Alert", message: "Your favorite has been added successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = filterResult{
            return result.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FutViewCell
        if let result = filterResult{
            let queue = DispatchQueue.init(label: "1")
            let homeImageUrl = URL(string: "https://footystats.org/img/\(result[indexPath.row].home_image)")
            let awayImageUrl = URL(string: "https://footystats.org/img/\(result[indexPath.row].away_image)")
            queue.async {
                let homeImageData = try? Data(contentsOf: homeImageUrl!)
                let awayImageData = try? Data(contentsOf: awayImageUrl!)
                DispatchQueue.main.async {
                    cell.imgHomeTeam.image = UIImage(data: homeImageData!)
                    cell.imgAwayTeam.image = UIImage(data: awayImageData!)
                }
                
            }
            cell.lblHomeTeamName.text = result[indexPath.row].home_name
            cell.lblAwayTeamName.text = result[indexPath.row].away_name
            cell.lblHomeTeamScore.text = "\(result[indexPath.row].homeGoalCount)"
            cell.lblAwayTeamScore.text = "\(result[indexPath.row].awayGoalCount)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addFavorite = UIContextualAction(style: .normal, title: "Favorite") { (action, view, nil) in
            if let result = self.filterResult{
                if let username = self.successUser?.username{
                    CoreDataService.shared.addMatchToUser(homeTeamName: result[indexPath.row].home_name, awayTeamName: result[indexPath.row].away_name, homeTeamScore: result[indexPath.row].homeGoalCount, awayTeamScore: result[indexPath.row].awayGoalCount, homeImage: result[indexPath.row].home_image, awayImage: result[indexPath.row].away_image, username: username)
                    self.showConfirmation()
                }
            
            }
            
        }
        addFavorite.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return UISwipeActionsConfiguration(actions: [addFavorite])
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResult = [match]()
        if let result = results {
            if searchText == ""{
                filterResult = result
            }else{
                for r in result {
                    if ((r.home_name.lowercased().contains(searchText.lowercased())) != false) || ((r.away_name.lowercased().contains(searchText.lowercased())) != false){
                        filterResult?.append(r)
                    }
                }
            }
            tblMatches.reloadData()
        }
    }
}
