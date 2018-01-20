//
//  SocketService.swift
//  Smack
//
//  Created by satkis on 1/10/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }

    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    
//    var socket : SocketIOClient = SocketIOClient(manager: NSURL(string: BASE_URL)! as! SocketManagerSpec, nsp: "/")
//
//    var socket = SocketIOClient(manager: URL(string: BASE_URL)! as! SocketManagerSpec, nsp: SocketIOClientConfiguration(arrayLiteral: SocketIOClientOption.connectParams(["jwt": token])))


    
    
    func establishConnection() {
        let socket = manager.defaultSocket
      socket.connect()
        print("socket connected::::::::")
    }
    
    func closeConnection() {
        let socket = manager.defaultSocket
       socket.disconnect()
        print("disconected from socket:::::::")
    }
    
    
    
    //send info from app to API
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
      
         let socket = manager.defaultSocket
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        print("add channel funkcija atlikta")
        
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        print("nuu kazkaaa::::::")
        
        let socket = manager.defaultSocket
        
        socket.on("channelCreated") { (dataArray, ack) in
            print("getChannel initiated::::::::::::::")
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            print("getChannellll:::::::::::::::")
            let newChannelll = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            MessageService.instance.channels.append(newChannelll)
            print("ka=kas ivyko???:::::")
            completion(true)
            print("kazas prisidejo?::::::::")
            
            }
        
    }
    //this is a func to add written message to API
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        let socket = manager.defaultSocket
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    
    //this is a func to get messages from DB
    func getMessage (completion: @escaping (_ newMessage: Message) -> Void) {
        let socket = manager.defaultSocket
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageTxt = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let messageTimeStamp = dataArray[7] as? String else { return }
            
            
            let newMessage = Message(message: messageTxt, username: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: messageTimeStamp)
            
            completion(newMessage)
            
            //before appening message need to check that message is written in selected channel. channel IDs need to match(we dont care if someone wrone message in other channel at same time
//            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
//
//
//
//            MessageService.instance.messages.append(newMessage)
//            completion(true)
//            print("message prideta::::::::::")
//            } else {
//                //do nothing is message's channelId doens't match with selected channelId
//                completion(false)
//            }
        }
    }

    
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        
        let socket = manager.defaultSocket
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            //this parses all users that are typing currently in a specific channel(channelId)
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
        
    }
    
    
    
    
    
    
    
    
    
}
