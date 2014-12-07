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
    
    /**
        Initializes new Local settings object.
    
        :param: Int game type: casual (0), random (1), custom (2)
        :param: String words' source or nil if there are no words' packages
    */
    public init(gameType: Int, wordsSource: String?) {
        self.gameType = gameType
        self.wordsSource = wordsSource
    }
    
    /**
        Public setter for the game type.
    
        :param: Int game type: casual (0), random (1), custom (2)
    */
    public func changeGameType(gameType: Int) {
        self.gameType = gameType
    }
    
    /**
        Public setter for the words' source.
    
        :param: String source of nil if there are no words' packages
    */
    public func changeWordsSource(source: String?) {
        self.wordsSource = source
    }
    
}