//
//  LoginVC.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }


    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_SIGNUP, sender: nil)
    }
    
    func setupView() {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])

        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
}
    
    
    }

