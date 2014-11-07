//
//  Settings.swift
//  TheHat
//
//  Created by Vadim Drobinin on 25/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

struct Settings {
    static var keys = ["", "showTutorial", "playersName", "playersNumber", "difficultness", "gameTime", "additionalTime",
        "playerWords"]
}

class LocalSettings {
    
    var gameType: Int // 0: Casual, 1: Random, 2: Custom
    var wordsSource: String // URL
    
    init(gameType: Int, wordsSource: String) {
        self.gameType = gameType
        self.wordsSource = wordsSource
    }
    
}