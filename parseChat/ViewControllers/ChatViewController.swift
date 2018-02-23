//
//  ChatViewController.swift
//  parseChat
//
//  Created by Godwin Pang on 2/22/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageInputField: UITextField!
    
    var messages: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.refresh), userInfo: nil, repeats: true)
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.message = self.messages?[indexPath.row]
        return cell
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageInputField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                self.messageInputField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func refresh(){
        let query = PFQuery(className: "Message")
        query.whereKeyExists("text").includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.messages = objects
                self.chatTableView.reloadData()
            } else {
                print("\(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    

}
