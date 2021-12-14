//
//  FavoritesViewController.swift
//  FlightApp
//
//  Created by user202286 on 12/12/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mytbl: UITableView!
    var favorites : [Favorites]?
    var filterFav : [Favorites]?
    var username : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        filterFav = favorites
    }
    @IBAction func btnDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fav = filterFav{
            return fav.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FutViewCell
        if let fav = filterFav{
            let queue = DispatchQueue.init(label: "1")
            let homeImageUrl = URL(string: "https://footystats.org/img/\(fav[indexPath.row].homeTeamImg!)")
            let awayImageUrl = URL(string: "https://footystats.org/img/\(fav[indexPath.row].awayTeamImg!)")
            queue.async {
                let homeImageData = try? Data(contentsOf: homeImageUrl!)
                let awayImageData = try? Data(contentsOf: awayImageUrl!)
                DispatchQueue.main.async {
                    cell.imgHomeTeam.image = UIImage(data: homeImageData!)
                    cell.imgAwayTeam.image = UIImage(data: awayImageData!)
                }
                
            }
            cell.lblHomeTeamName.text = fav[indexPath.row].homeTeamName
            cell.lblAwayTeamName.text = fav[indexPath.row].awayTeamName
            cell.lblHomeTeamScore.text = fav[indexPath.row].homeTeamScore
            cell.lblAwayTeamScore.text = fav[indexPath.row].awayTeamScore
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let result = filterFav{
                filterFav?.remove(at: indexPath.row)
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
                CoreDataService.shared.deleteMatchFromUser(homeTeamName: result[indexPath.row].homeTeamName!, awayTeamName: result[indexPath.row].awayTeamName!, homeTeamScore: result[indexPath.row].homeTeamScore!, awayTeamScore: result[indexPath.row].awayTeamScore!, username: self.username!)
            }
            
        }
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, nil) in
//            if let result = filterFav{
//                filterFav = [Favorites]()
//                filterFav = CoreDataService.shared.deleteMatchFromUser(homeTeamName: result[indexPath.row].homeTeamName!, awayTeamName: result[indexPath.row].awayTeamName!, homeTeamScore: result[indexPath.row].homeTeamScore!, awayTeamScore: result[indexPath.row].awayTeamScore!, username: self.username!)
//                tableView.reloadData()
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFav = [Favorites]()
        if let fav = favorites {
            if searchText == ""{
                filterFav = fav
            }else{
                for f in fav {
                    if ((f.homeTeamName?.lowercased().contains(searchText.lowercased())) != false) || ((f.awayTeamName?.lowercased().contains(searchText.lowercased())) != false){
                        filterFav?.append(f)
                    }
                }
            }
            mytbl.reloadData()
        }
    }
}
