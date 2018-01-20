//
//  CustomButton.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    
    override func awakeFromNib() {
        layer.cornerRadius = 3.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 7.0
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    }

    
}
