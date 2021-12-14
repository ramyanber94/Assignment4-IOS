//
//  ViewController.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var user : User? = User()
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        if let userName = txtUserName.text{
            if let password = txtPassword.text{
                if CoreDataService.shared.getUser(username: userName , password: password) != nil{
                    user = CoreDataService.shared.getUser(username: userName , password: password)
                    self.performSegue(withIdentifier: "leaguesSegue", sender: sender)
                }else{
                    showError()
                }
            }
        }
    }
    func showError(){
        let alertController = UIAlertController(title: "Alert", message: "Invalid password or username", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { [self]
            (action: UIAlertAction!) in
            txtPassword.text = ""
            txtUserName.text = ""
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leaguesSegue" {
            let SVC = segue.destination as! LeagueViewController
            SVC.successUser = user
        }
    }
       
}


