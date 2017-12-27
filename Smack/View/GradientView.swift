//
//  GradientView.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

//this allows to show design in storyboard
@IBDesignable

class GradientView: UIView {

    //these will alow to change colors in storyboard dinamically (created buttons in storyboard)
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    }

    //this is called when @IBInspectable is changed
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
