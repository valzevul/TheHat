//
//  Settings.swift
//  TheHat
//
//  Created by Vadim Drobinin on 25/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

/// Globa settings
struct Settings {
    
    /// Tags for local game settings
    static var keys = ["", "showTutorial", "playersName", "playersNumber", "difficultness", "gameTime", "additionalTime",
        "playerWords"]
}

/// Local settings for the current game
public class LocalSettings {
    
    /// Game type
    /// - Casual (0) - pair-to-pair
    /// - Random (1) - one to others
    /// - Custom (2) - ???
    public private(set) var gameType = 0
    
    /// Link to the words' source (if playing with a package)
    public private(set) var wordsSource: String? = nil
    
    public init(gameType: Int, wordsSource: String?) {
        self.gameType = gameType
        self.wordsSource = wordsSource
    }
    
}