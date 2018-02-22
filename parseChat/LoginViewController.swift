//
//  LoginViewController.swift
//  parseChat
//
//  Created by Godwin Pang on 2/22/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    let signUpUsernameErrorAlertController = UIAlertController(title: "Username Required", message: "Please enter username", preferredStyle: .alert)
    let signUpPasswordErrorAlertController = UIAlertController(title: "Password Required", message: "Please enter password", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        //does nothing -> dismisses alert view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpUsernameErrorAlertController.addAction(OKAction)
        signUpPasswordErrorAlertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerUser(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameInputField.text
        newUser.password = passwordInputField.text
        
        if (usernameInputField.text?.isEmpty)!{
            present(signUpUsernameErrorAlertController, animated: true)
        } else if (passwordInputField.text?.isEmpty)!{
            present(signUpPasswordErrorAlertController, animated: true)
        } else {
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                print("User Registered successfully")
                if let error = error {
                    let signUpErrorAlertController = UIAlertController(title: "Signup Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    signUpErrorAlertController.addAction(self.OKAction)
                    //self.present(signUpErrorAlertController, animated: true)
                } else {
                    print("User Registered successfully")
                    //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        let username = usernameInputField.text ?? ""
        let password = passwordInputField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            print("User logged in successfully")
            if let error = error {
                let loginErrorAlertController = UIAlertController(title: "Login Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                loginErrorAlertController.addAction(self.OKAction)
                self.present(loginErrorAlertController, animated: true)
            } else {
                print("User logged in successfully")
                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
}

