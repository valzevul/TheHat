//
//  CustomPlayerTableCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 28/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//


import UIKit

/// Class of a custom player table cell
class CustomPlayerTableCell: MGSwipeTableCell {
    
    /// Player's name
    @IBOutlet weak var playerLabel: UILabel!
    
    /// Player's icon
    @IBOutlet weak var playerIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

