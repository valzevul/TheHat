//
//  Game.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

/// Game object with players, words, etc.
public class Game {
    
    /// Dictionary with a list of parsed words
    let dict: Dictionary
    
    /// List of active words (with statuses and statistics)
    public var words = [ActiveWord]() // Words with statuses and statistics
    
    /// List of players
    var players = [Player]()
    
    /// Expected number of words based on number of players and default settings
    let numberOfWords: Int?
    
    /// Loaded global settings
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    /// Active words left
    public var wordsLeft: Int {
        get {
            return words.count
        }
    }
    
    /// Number of players
    public var numberOfPlayers: Int {
        get {
            return players.count
        }
    }
    
    /**
        Initializes new Game object.
    
        :param: numberOfPlayers Number of players
        :param: words Number of words per player
        :param: filename String name of the file with words
    */
    init(numberOfPlayers: Int, words: Int, filename: String) {
        self.numberOfWords = words
        dict = Dictionary(filename: filename)
        dict.parse()
        
        let ownerName: String = namePreference.stringForKey("playersName")!
        
        self.addPlayer(getNewPlayer(ownerName, numberOfWords: words))
    }
    
    // MARK: - Player
    
    /**
        Create new Player object with words.
    
        :param: idx Int id of the player
        :param: numberOfWords Int number of current player's words
    
        :returns: Player object with words.
    */
    public func getNewPlayer(idx: Int, numberOfWords: Int) -> Player {
        let player = Player(name: Game.getRandomName(idx))
        for i in 0..<numberOfWords {
            let word = getRandomWord(player) // TODO: Fix for the case when words more than 10 & for the case when idx > number of words
            player.addWord(word)
        }
        return player
    }
    
    /**
    Create new Player object with words and name.
    
    :param: name String player's name
    :param: numberOfWords Int number of current player's words
    
    :returns: Player object with words.
    */
    public func getNewPlayer(name: String, numberOfWords: Int) -> Player {
        let player = Player(name: name)
        for i in 0..<numberOfWords {
            let word = getRandomWord(player) // TODO: Fix for the case when words more than 10 & for the case when idx > number of words
            player.addWord(word)
        }
        return player
    }
    
    /**
        Add player to the list of players and append new words to the full list.
    
        :param: player Player object to be added
    */
    public func addPlayer(player: Player) {
        players.append(player)
        for word in player.getWords() {
            words.append(ActiveWord(word: word, status: "?"))
        }
    }
    
    /**
        Returns player based on index.
    
        :param: index Player's index
        :returns: Player object with the same index
    */
    public func getPlayerByIndex(index: Int) -> Player {
        return players[index] // TODO: or nil in case of empty array or index > count
    }
    
    /**
        Generate one new name.
    
        :param: idx Int index to make the name unique
        :returns: String based on index
    */
    class func getRandomName(idx: Int) -> String {
        var name = ""
        name = "Player " + String(idx) // For dev purposes only!
        return name
    }
    
    // MARK: - Word
    
    /**
        Generate new word.
    
        :param: owner Player object in need of a new word
        :returns: Word object for the Player
    */
    func getRandomWord(owner: Player) -> Word {
        let text = self.dict.getNewWord()
        return Word(owner: owner, text: text!)
    }

    // MARK: - Game
    
    /**
        Create random game.
    
        :param: numberOfPlayers Int number of players
        :param: numberOfWords Int number of words per player
    
        :returns: Game object
    */
    public class func createRandomGame(numberOfPlayers: Int, numberOfWords: Int) -> Game {
        var newRandomGame = Game(numberOfPlayers: numberOfPlayers, words: numberOfWords, filename: "dict")
        
        for idx in 2...numberOfPlayers {
            let newPlayer = newRandomGame.getNewPlayer(idx, numberOfWords: numberOfWords)
            newRandomGame.addPlayer(newPlayer)
        }
        
        return newRandomGame
    }
    
    /**
        Removes a player and all his words from the game.
    
        :param: index Int index of the player in array.
    */
    public func removePlayerAtIndex(index: Int) {
        
        // Remove words
        var counter = words.count - 1
        while (counter >= 0) {
            if (words[counter].getOwner().getName() == players[index].getName()) {
                words.removeAtIndex(counter)
                counter -= 1
            }
            counter -= 1
        }
        
        // Remove player from list
        players.removeAtIndex(index)
        
    }
    
    /**
        Gets all player's words from the list of ActiveWords.
        
        :param: idx Int player's index
        
        :returns: [ActiveWord] list of Active Words
    */
    public func wordsForPlayer(idx: Int) -> [ActiveWord] {
        
        var results = [ActiveWord]()
        let player_name = players[idx].getName()
        
        for word in words {
            if (word.getOwner().getName() == player_name) {
                results.append(word)
            }
        }
        
        return results
        
    }
    
    /**
        Removes player's word from the list.
    
        :param: word ActiveWord to be deleted.
    */
    public func removeWord(word: ActiveWord) {
        
        for i in 0..<words.count {
            
            if ((word.getOwner().getName() == words[i].getOwner().getName()) && (word.getText() == words[i].getText())) {
                words.removeAtIndex(i)
                break
            }
        }
        
    }
    
    /**
        Changes player's word.
    
        :param: word ActiveWord word to be changed
        :param: text String new value or nil
    
    */
    public func changeWord(word: ActiveWord, text: String?) {
        
        for w in words  {
            if ((w.getOwner().getName() == word.getOwner().getName()) && (w.getText() == word.getText())) {
                w.changeText(text)
            }
        }
        
    }
    
}