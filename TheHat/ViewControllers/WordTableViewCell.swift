//
//  WordTableViewCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class WordTableViewCell: MGSwipeTableCell {

    
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
