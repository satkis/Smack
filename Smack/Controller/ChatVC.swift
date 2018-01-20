//
//  ChatVC.swift
//  Smack
//
//  Created by satkis on 12/27/17.
//  Copyright © 2017 satkis. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //this is outlet(not action) because actions included manually in viewdidload
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var sendBttn: UIButton!
    @IBOutlet weak var usersTypingLbl: UILabel!
    
    // Variables
    
    var isTyping = false
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
        //to make messagecell dynamic according how long is text need setup lines to 0 in MainStoryboard for messageTextField and below two lines:
        //estimate needs to be less than tableViewCell height in tableView
        tableVIew.estimatedRowHeight = 62
        tableVIew.rowHeight = UITableViewAutomaticDimension
        sendBttn.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action:
            //revealToggle to slide out for anotherViewController. like for CityBee app when car selected
            #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //slide with finger viewController from a side
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //tap anywhere to close slided viewcontroller
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableVIew.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let indexx = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableVIew.scrollToRow(at: indexx, at: .bottom, animated: false)
                }
            }
        }
        
        //how to scroll to very bottom when nes message is posted (so that latest message will be visible in tableVIew)
//        SocketService.instance.getMessage { (success) in
//            if success {
//                self.tableVIew.reloadData()
//                print("RELOADED MESSAGES::::::::")
//                if MessageService.instance.messages.count > 0 {
//                   // self.tableVIew.reloadRows(at: [IndexPath(row: MessageService.instance.messages.count - 1, section: 0)], with: .bottom)
//                    let indexx = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableVIew.scrollToRow(at: indexx, at: .bottom, animated: false)
//
//               }
//            }
//        }
       
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                //we do if here, becasue we dont want to show our own name to ourself when typing
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.usersTypingLbl.text = "\(names) \(verb) tying..."
            } else {
                //when everyone stopped typing
                self.usersTypingLbl.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.fingUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
            tableVIew.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        print("updateWithChannel::::::::")
        // writing - ?? "" - in case selected channel name not found, hence, insert empty
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
          print("PASIKEITE CHANNEL NAME IN ChatVC")
        getMessages()
        print("getMessages TRIGERINOSI INSIDE updateWithChannel func:::::::::::")
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                } else {
                    self.channelNameLbl.text = "No channels yet! Crate the first to begin!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success {
              
                self.tableVIew.reloadData()
            }
        }
    }
    
    //when created selected Action and EVENT: Editing Changed"
   
    @IBAction func textBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        
        if messageTxtBox.text == "" {
            isTyping = false
            sendBttn.isHidden = true
        SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                sendBttn.isHidden = false
                SocketService.instance.manager.defaultSocket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                    SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
            }
        }

    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configueCell(message: message)
            return cell
        } else {
            //if no message found, then returns empty tableview cell
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
    
    
    
    
    
}
