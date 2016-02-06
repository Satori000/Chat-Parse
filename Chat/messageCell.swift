//
//  messageCell.swift
//  Chat
//
//  Created by Shakeeb Majid on 2/5/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
