//
//  Constants.swift
//  TheHat
//
//  Created by Vadim Drobinin on 20/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation
import UIKit

/// List of global constants
struct Constants {
    
    // MARK: - Background colors
    static let lightGreen = UIColor(red: 175.0/255.0, green: 240.0/255.0, blue: 203.0/255.0, alpha: 1.0)
    static let lightGrey = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)

    // MARK: - Game params
    static let playersInRound = 2
    
    // MARK: - Words settings
    static let deleteColor = UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 0.7)
    static let editColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 0.7)
    static let addColor = UIColor(red: 0.07, green: 0.75, blue: 0.16, alpha: 0.7)
    
    // MARK: - Words statuses
    
    static let OK = "OK"
    static let F = "F"
    static let M = "?"
    
    static let OKColor = UIColor(red: 0.07, green: 0.75, blue: 0.16, alpha: 0.7)
    static let FColor = UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 0.7)
    static let MColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 0.7)
    
    // MARK: - Words complexity
    static let DEFAULT_COMPLEXITY = 50
    
    static let EASY_POINTS = 21
    static let NORMAL_POINTS = 51
    static let DIFFICULT_POINTS = 81
    static let HARD_POINTS = 101
    
    static let EASY = "Easy"
    static let NORMAL = "Normal"
    static let DIFFICULT = "Difficult"
    static let HARD = "Hard"
    static let UNKNOWN = "Unknown"
    
    static let DEFAULT_NAME = "Player 1"
}