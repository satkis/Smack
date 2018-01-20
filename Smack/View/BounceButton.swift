//
//  BounceButton.swift
//  Smack
//
//  Created by satkis on 1/20/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

class BounceButton: CustomButton {
    
    
    //https://www.youtube.com/watch?v=jWobdUlUWQ0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
    

    
}
    
