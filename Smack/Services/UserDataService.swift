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
    
}
