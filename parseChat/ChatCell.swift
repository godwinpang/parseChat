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

    var message: PFObject! {
        didSet{
            
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
