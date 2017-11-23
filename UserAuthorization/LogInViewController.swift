//
//  LogInViewController.swift
//  UserAuthorization
//
//  Created by Roman Bakhilov on 23.11.2017.
//  Copyright © 2017 Roman Bakhilov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchLogIn(_ sender: Any) {
        
    }
    
    @IBAction func onTouchSignUp(_ sender: Any) {
        let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.present(signUpViewController, animated: true)
    }
}
