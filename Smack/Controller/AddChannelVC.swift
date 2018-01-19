//
//  AddChannelVC.swift
//  Smack
//
//  Created by satkis on 1/7/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    // Outlets
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        channelName.attributedPlaceholder = NSAttributedString(string: "channel name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelNamee = channelName.text , channelName.text != "" else { return }
        guard let channelDesc = channelDescription.text else { return }
        
//        SocketService.instance.manager.defaultSocket.on(clientEvent: .connect) { dataArray, ack in
//            print("smthhh::::")
//        }
        
        SocketService.instance.addChannel(channelName: channelNamee, channelDescription: channelDesc) { (success) in
            if success {
              
                print("sukurtas channel jau:::::::::::")
                self.dismiss(animated: true, completion: nil)
                print("uzsidare kanalo kurimo langas:::::::::")
            }
        }
        
        
        
        
        
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
}
