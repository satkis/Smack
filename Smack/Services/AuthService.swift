//
//  AuthService.swift
//  Smack
//
//  Created by satkis on 12/28/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import Foundation
import Alamofire
//SwiftJson handles null values. if null, then brings empty string
import SwiftyJSON

//this spot handles login, create, register user functions


//this is singleton class. Singleton: In object-oriented programming , a singleton class is a class that can have only one object (an instance of the class) at a time.
//class accessible globally and only one instance available at a time
class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
                
            }
        }
        
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //.responseJSON is used in this case because API(mac-chat-api) is built to return JSON. Usualy .responseString is used.
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in

            switch response.result {
            case .success(_):
                if let data = response.data {
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
                }
                break
            case .failure(_):
                completion(false)
                debugPrint(response.result.error as Any)
            break
        }
            
////PARSING JSON OLDFASHIONED////
            // if response.result.error == nil {
            
               // String is a key - e.g. "password", but password value can be integer, String, etc - so, use Any>
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
              
//PARSING JSON USING SWIFTYJSON////
//                guard let data = response.data else { return }
//                let json = JSON(data: data)
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
            
//end of SWIFTY JSON
                
//                self.isLoggedIn = true
//                completion(true)
//            } else {
//                completion(false)
//                debugPrint(response.result.error as Any)
//            }
//        }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                if let data = response.data {
                    self.setUserInfo(data: data)
                    completion(true)
                }
                break
            case .failure(_):
                completion(false)
                debugPrint(response.result.error as Any)
                break
            }
        }
    }
    
    func fingUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)/\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    self.setUserInfo(data: data)
                    completion(true)
                }
                break
            case .failure(_):
                completion(false)
                debugPrint(response.result.error as Any)
                break
            }
        
        }
        
    }

    func setUserInfo(data: Data) {
    
        let json = JSON(data)
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
