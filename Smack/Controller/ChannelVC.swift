//
//  ChannelVC.swift
//  Smack
//
//  Created by satkis on 12/27/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var userImg: CircleImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    //in this function define what to do when user logs in or registers
   @objc func userDataDidChange(_ notif: Notification) {
    if AuthService.instance.isLoggedIn {
        loginBtn.setTitle(UserDataService.instance.name, for: .normal)
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    } else {
        //show when logged out (i.e. same as not logged in)
        loginBtn.setTitle("Login", for: .normal)
        userImg.image = UIImage(named: "menuProfileIcon")
        userImg.backgroundColor = UIColor.clear
    }
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //show profile page xib
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
    }
    
    }

}
