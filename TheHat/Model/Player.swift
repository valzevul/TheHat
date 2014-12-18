//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation
import UIKit

/// Player object with words and other info
public class Player {
    
    /// List of plain words
    private var words = [Word]()
    
    ///  Player's name
    private var name: String?
    
    /// Player's id (starts from 0)
    private var index: Int?
    
    /// Player's image in case of import from address book
    private var image: UIImage?
    
    /// Score for the results
    private var scoreExplained = 0
    
    /// Score for the results
    private var scoreGuessed = 0
    
    /// Team ID
    public private(set) var teamId = -1
    
    /**
        Initializes player from the given name.
    
        :param: name String name of player
    */
    init(name: String) {
        self.name = name
    }
    
    /**
        Initializes player from the given name and an image from the address book.
    
        :param: name String name of player
        :param image UIImage from address book
    */
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    /**
        Adds new word to the list.
    
        :param: word Word object to add to the list
    */
    func addWord(word: Word) {
        self.words.append(word)
    }
    
    /**
        Give player new index.
    
        :param: Int index
    */
    func setIndex(index: Int) {
        if (index >= 0) {
            self.index = index
        }
    }
    
    /**
        Returns list of Word objects.
    
        :return: list of plain Word objects
    */
    func getWords() -> [Word] {
        return words
    }
    
    /**
        Returns overall score (as sum of explained and guessed words).
    
        :return: Int result
    */
    func getOverallScore() -> Int {
        return self.scoreExplained + self.scoreGuessed
    }
    
    /**
        Setter for the name field.
    
        :param: name String name to set
    */
    func setName(name: String) {
        self.name = name
    }
    
    /**
        Getter for the name field.
    
        :return: player's name or nil if not existed
    */
    func getName() -> String? {
        return self.name
    }
    
    /**
        Decrease number of explained words.
    */
    func decScoreExplained() {
        self.scoreExplained -= 1
    }
    
    /**
        Decrease number of guessed words.
    */
    func decScoreGuessed() {
        self.scoreGuessed -= 1
    }

    
    /**
        Increase number of explained words.
    */
    func incScoreExplained() {
        self.scoreExplained += 1
    }
    
    /**
        Increase number of guessed words.
    */
    func incScoreGuessed() {
        self.scoreGuessed += 1
    }
    
    /**
        Getter for the image field.
    
        :return: UIImage object or nil if not existed
    */
    func getImage() -> UIImage? {
        return self.image
    }
    
    /**
        Returns the number of player's words.
    
        :returns: Int number of player's words
    */
    func getNumberOfWords() -> Int {
        return words.count
    }
    
    /**
        Set player's team id.
    
        :param: id Int player's team id
    */
    func setTeamId(id: Int) {
        teamId = id
    }
}