//
//  SignUpViewController.swift
//  UserAuthorization
//
//  Created by Roman Bakhilov on 23.11.2017.
//  Copyright © 2017 Roman Bakhilov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onTouchSignUp(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            showAlert(with: "Fill first username")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(with: "Fill password")
            return
        }
        guard let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else {
            showAlert(with: "Fill repeat password")
            return
        }
        
        let newActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        newActivityIndicator.center = view.center
        newActivityIndicator.hidesWhenStopped = false
        newActivityIndicator.startAnimating()
        view.addSubview(newActivityIndicator)
        
        let servURL = URL(string: "http://46.101.73.111:7000/")
        var request = URLRequest(url: servURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["username": userNameTextField.text!,
                          "password": passwordTextField.text!,
                          ] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
            displayMessage(with: "Something went wrong")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.removeActivityIndicator(activityIndicator: newActivityIndicator)
            
            if error != nil {
                self.displayMessage(with: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    let userId = parseJSON["userId"] as? String
                    print("User id: \(String(describing: userId!))")
                    
                    if (userId?.isEmpty)! {
                        self.displayMessage(with: "Could not successfully perform this request.")
                        return
                    } else {
                        self.displayMessage(with: "Successfully registered.")
                    }
                    
                } else {
                    self.displayMessage(with: "Could not successfully perform this request. Please try again later")
                }
            } catch {
                self.removeActivityIndicator(activityIndicator: newActivityIndicator)
                self.displayMessage(with: "Could not successfully perform this request. Please try again later")
            }
        }
        task.resume()
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(with title: String) {
        print(title)
        let alert = UIAlertController(title: "Warning", message: title, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { (action: UIAlertAction) in
            print("Ok button tapped")
        }
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
        
    func displayMessage(with title: String) {
        print(title)
        let alert = UIAlertController(title: "Warning", message: title, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { (action: UIAlertAction) in
            print("Ok button tapped")
        }
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
