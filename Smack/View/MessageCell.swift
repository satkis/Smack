//
//  MessageCell.swift
//  Smack
//
//  Created by satkis on 1/20/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    func configueCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.username
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
    
    
    
    
    
    
    
    
    
    
}
