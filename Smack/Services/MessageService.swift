//
//  MessageService.swift
//  Smack
//
//  Created by satkis on 1/6/18.
//  Copyright © 2018 satkis. All rights reserved.
//


// This is responsible for storing messages&channels and functions that will retrieve messages&and channels + some other utilities

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            //print("PAEJO?")
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    
                 let json = try JSON(data: data).array
                    print("DZEISON: \(try JSON(data: data).array as Any)")
                    for item in json! {
                        
                        
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                    print("kanalaiiii: \(self.channels[0].channelTitle)")
                } catch {
                    print("smth wrong")
                }
            } else {
                completion(false)
                debugPrint("komentaras \(response.result.error as Any)")
            }
            
            
//            if response.result.error == nil {
//                guard let data = response.data else { return }
//
//                do {
//
//                let json = try JSON(data: data).array
//                    print("DZEISON: \(try JSON(data: data).array as Any)")
//                    for item in json! {
//                        let name = item["name"].stringValue
//                        let channelDescription = item["description"].stringValue
//                        let id = item["_id"].stringValue
//
//                        //initialize new channel object (when created by user). then this 'channel' get stored in Channel Message Service. above show 'var channels...
//                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                        //adds newly customer's created channel to the list
//                        self.channels.append(channel)
//
//                    }
//                    print("kanalaiiii: \(self.channels[0].channelTitle)")
//                    completion(true)
//
//            } catch {
//                completion(false)
//                debugPrint("komentaras \(response.result.error as Any)")
//            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
        print("remove channel func done:::::::::")
    }
    
    
    
    }


