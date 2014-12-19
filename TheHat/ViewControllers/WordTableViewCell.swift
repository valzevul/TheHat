//
//  WordTableViewCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for a word's representation.
class WordTableViewCell: MGSwipeTableCell {

    /// Word's label
    @IBOutlet weak var wordsLabel: UILabel!
    
    /// Complexity label
    @IBOutlet weak var complexityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
