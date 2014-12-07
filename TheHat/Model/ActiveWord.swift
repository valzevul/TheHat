//
//  ActiveWord.swift
//  TheHat
//
//  Created by Vadim Drobinin on 27/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

/// Active word is a word playing in the current game
public class ActiveWord: Word {
    
    /// Status of the word:
    /// - ? (unknown)
    /// - OK (guessed)
    /// - F (failed)
    private var status: String = ""
    
    /// Variable for the statistics, amount of time spent to guess the word
    private var guessedTime = 0
    /// Variable for the statistics, number of attempts to guess the word
    private var attemptsNumber = 0
    
    // MARK: - Initializers
    
    /**
        Initializes an Active word object from the scratch.
    
        :param: owner Player object added the word
        :param: text String object represents the word
        :param: status String object represents the status of the word (guessed or not)
        :returns: Active word object
    */
    init(owner: Player, text: String, status: String) {
        super.init(owner: owner, text: text)
        self.status = status
    }
    
    /**
        Initializes an Active word object from Word object.
    
        :param: word Word object
        :param: status String object represents the status of the word (guessed or not)
        :returns: Active word object
    */
    init(word: Word, status: String) {
        super.init(owner: word.getOwner(), text: word.getText())
        self.status = status
    }
    
    // MARK: - Status
    
    /**
        Getter for status of the word.
    
        :returns: String for the status of word
    */
    func getStatus() -> String {
        return status
    }
    
    /**
        Setter for status of the word.
    
        :param: status Value for the status to be changed.
    */
    func changeStatus(status: String) {
        self.status = status
    }
    
    // MARK: - Statistics
    
    /**
        Getter for the time statistics.
    
        :returns: Int for the amount of time spent to guess the word
    */
    func getTime() -> Int {
        return guessedTime
    }
    
    /**
        Setter for the time statistics.
    
        :param: time Value for the time statistics to be added.
    */
    func incTime(time: Int) {
        guessedTime += time
    }
    
    /**
        Getter for the attempts statistics.
    
        :returns: Int for the number of attempts spent to guess the word
    */
    func getAttemptsNumber() -> Int {
        return attemptsNumber
    }
    
    /**
        Setter for the attempts statistics.
    */
    func incAttemptsNumber() {
        attemptsNumber += 1
    }
}