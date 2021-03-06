//
//  AddressBookTableViewCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 13/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import AddressBook

/// Class provides an interface for the cell at view with import from address book
class AddressBookTableViewCell: UITableViewCell {
    
    /// Player name to be displayed
    @IBOutlet weak var playerNameLabel: UILabel!
    
    /// Player's image
    @IBOutlet weak var playerImageView: UIImageView!
    
    /// Player's idx
    var idx: ABRecordID?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
