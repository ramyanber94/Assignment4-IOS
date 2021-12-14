//
//  RegisterUserController.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import UIKit
import CoreData

class RegisterUserController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCreateUser(_ sender: Any) {
        if let firstname = txtFirstName.text{
            if let lastname = txtLastName.text{
                if let username = txtUserName.text{
                    if let password = txtPassword.text{
                        CoreDataService.shared.addUser(firstName: firstname, lastName: lastname, userName: username, password: password)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
