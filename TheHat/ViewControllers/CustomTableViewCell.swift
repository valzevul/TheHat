//
//  CustomTableViewCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 27/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class of a custom table cell wuth word's status after the round
class CustomTableViewCell: MGSwipeTableCell {

    /// Word text
    @IBOutlet weak var wordLabel: UILabel!
    
    /// Word status image
    @IBOutlet weak var wordResultImage: UIImageView!
    
    /// Word status label
    @IBOutlet weak var wordResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
