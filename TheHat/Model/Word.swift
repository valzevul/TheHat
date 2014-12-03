//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

/// A word: the main construction in the game. Consists of owner and text (description).
public class Word {
    
    /// The owner of the word
    private let owner: Player
    /// The text representation of the word
    private var text: String
    
    /**
        Initializes a new Word object.
    
        :param: owner the Player object added the word
        :param: text the String representation of the word
    
        :returns: New Word object
    */
    init(owner: Player, text: String) {
        self.owner = owner
        self.text = text
    }

    /**
        Owner is a player, who add the word to the game.
    
        :returns: Player object
    */
    public func getOwner() -> Player {
        return owner
    }

    /**
        Text is a representation of a word at the screen.
    
        :returns: String object
    */
    public func getText() -> String {
        return text
    }
    
    /**
        Changes the text of a word.
    
        :param: text String text value or nil
    */
    func changeText(text: String?) {
        if let t = text {
            self.text = t
        }
    }
}