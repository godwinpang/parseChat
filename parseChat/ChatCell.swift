//
//  ChatCell.swift
//  parseChat
//
//  Created by Godwin Pang on 2/22/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            messageLabel.text = message.object(forKey: "text") as? String
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
