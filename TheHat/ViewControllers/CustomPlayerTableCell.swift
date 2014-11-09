//
//  CustomPlayerTableCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 28/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//


import UIKit

class CustomPlayerTableCell: MGSwipeTableCell {
    

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerIconImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

