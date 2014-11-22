//
//  GameResultsTableViewCell.swift
//  TheHat
//
//  Created by Vadim Drobinin on 11/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class provides an interface for the cell at view with game results
class GameResultsTableViewCell: UITableViewCell {

    /// Player's image from the address book
    @IBOutlet weak var PlayerImageView: UIImageView!
    
    /// Player's name
    @IBOutlet weak var playerNameLabel: UILabel!
    
    /// Player's summary score (guessed + explained words)
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
