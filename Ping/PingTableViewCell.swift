//
//  PingTableViewCell.swift
//  Ping
//
//  Created by Derek Bassett on 4/14/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import UIKit

class PingTableViewCell: UITableViewCell {

    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
