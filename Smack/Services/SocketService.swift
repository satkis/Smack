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
    
}
