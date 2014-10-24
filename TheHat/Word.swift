//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

public struct Word {
    
    private let owner: Player
    private let text: String
    
    init(owner: Player, text: String) {
        self.owner = owner
        self.text = text
    }
    
    public func getOwner() -> Player {
        return owner
    }
    
    public func getText() -> String {
        return text
    }
}