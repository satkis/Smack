//
//  ChatVC.swift
//  Smack
//
//  Created by satkis on 12/27/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //this is outlet(not action) because actions included manually in viewdidload
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action:
            //revealToggle to slide out for anotherViewController. like for CityBee app when car selected
            #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //slide with finger viewController from a side
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //tap anywhere to close slided viewcontroller
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.fingUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        MessageService.instance.findAllChannel { (success) in
            
        }
        
    }

    
    
}
