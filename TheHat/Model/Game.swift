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
    let dict: JSONDictionary
    
    /// List of active words (with statuses and statistics)
    public var words = [GameWord]() // Words with statuses and statistics
    
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
        dict = JSONDictionary(filename: filename)
        
        let ownerName: String = namePreference.stringForKey("playersName") ?? Constants.DEFAULT_NAME
        let newPlayer = getNewPlayer(ownerName, numberOfWords: words)
        newPlayer.setTeamId(0)
        self.addPlayer(newPlayer)
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
        for word in player.words {
            let gw = GameWord(owner: player, word: word)
            self.words.append(gw)
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
    func getRandomWord(owner: Player) -> ImportedWord {
        return self.dict.getNewWord()!
    }

    // MARK: - Game
    
    /**
        Create random game.
    
        :param: numberOfPlayers Int number of players
        :param: numberOfWords Int number of words per player
    
        :returns: Game object
    */
    
    public class func createRandomGame(numberOfPlayers: Int, numberOfWords: Int) -> Game {
        return createRandomGame(numberOfPlayers, numberOfWords: numberOfWords, dict: "dict")
    }
    
    public class func createRandomGame(numberOfPlayers: Int, numberOfWords: Int, dict: String) -> Game {
        var newRandomGame = Game(numberOfPlayers: numberOfPlayers, words: numberOfWords, filename: dict)
        
        for idx in 2...numberOfPlayers {
            let newPlayer = newRandomGame.getNewPlayer(idx, numberOfWords: numberOfWords)
            newPlayer.setTeamId((idx - 1) / 2)
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
            if (words[counter].owner.getName() == players[index].getName()) {
                words.removeAtIndex(counter)
                counter -= 1
            }
            counter -= 1
        }
        
        // Remove player from list
        players.removeAtIndex(index)
        
    }
    
    /**
        Gets all player's words from the list of GameWords.
        
        :param: idx Int player's index
        
        :returns: [GameWord] list of Game Words
    */
    public func wordsForPlayer(idx: Int) -> [GameWord] {
        
        var results = [GameWord]()
        let player_name = players[idx].getName()
        
        for word in words {
            if (word.owner.getName() == player_name) {
                results.append(word)
            }
        }
        
        return results
        
    }
    
    /**
        Removes player's word from the list.
    
        :param: word GameWord to be deleted.
    */
    public func removeWord(word: GameWord) {
        
        for i in 0..<words.count {
            
            if ((word.owner.getName() == words[i].owner.getName()) && (word.text == words[i].text)) {
                words.removeAtIndex(i)
                break
            }
        }
        
    }
    
    
    /**
        Checks if there is a player with the same name.
    
        :param: name String
        :returns Bool true if the name exists
    */
    public func isNameUnique(name: String) -> Bool {
        for player in players {
            if (player.getName() == name) {
                return false
            }
        }
        return true
    }
    
}