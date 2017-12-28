//
//  CustomTextFIeld.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class CustomTextFIeld: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
    }
    
    //For placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 0.0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 25.0, dy: 0.0)
    }
    
}

