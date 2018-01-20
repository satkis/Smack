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
        
        
        guard var isoDate = message.timeStamp else { return }
      //  let start = isoDate.index(isoDate.startIndex, offsetBy: 1)
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        //isoDate = isoDate.substring(to: end)
        let isoDatee = isoDate[..<end]
        //isoDate = Substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDatee.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
