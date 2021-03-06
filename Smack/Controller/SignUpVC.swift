//
//  SignUpVC.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    
    // Variables
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
   
    @IBAction func signUpExit(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    @IBAction func createAcctPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvaterPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickBgCollorPressed(_ sender: Any) {
        
    }
    
    
}
