//
//  UserDataService.swift
//  Smack
//
//  Created by satkis on 1/3/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    //public allows to read value for other classes. private(set) allows to change value only in this file
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        
        
        //from mlab DB::: "avatarColor": "[0.509803921568627, 0.666666666666667, 0.341176470588235, 1]",
        //below stuf needed to generate color using avatarColor string values from mlab DB.
        
        //rules for scanning avatarColor values in mlab DB
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        //extract values and put as variables using scanning rules above
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
    
        //NString is optional, so default value is needed if values not parsed successfully
        let defaultColor = UIColor.lightGray
        
        //unwrapping values, because NSString is optional
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        //there's no way to smage CGFloat from Strings. so, stirngs changed to doubles and double to CGFloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        //set up new color with new CGFloat
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
        
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
       // MessageService.instance.clearChannels()
    }
    
    
    
    
    
    
}
