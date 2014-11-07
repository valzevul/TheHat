//
//  Game.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

public class Game {
    
    var players = [Player]() // List of players
    let numberOfWords: Int? // Predicted number of words
    
    public var words = [ActiveWord]() // Words with statuses and statistics
    public var wordsLeft: Int {
        get {
            return words.count // TODO: change for avoiding guessed words
        }
    }
    
    public var numberOfPlayers: Int {
        get {
            return players.count
        }
    }
    
    init(numberOfPlayers: Int, words: Int) {
        self.numberOfWords = words
        self.addPlayer(getNewPlayer(1, numberOfWords: words))
    }
    
    // MARK: - Player
    
    public func getNewPlayer(idx: Int, numberOfWords: Int) -> Player {
        let player = Player(name: Game.getRandomName(idx))
        for i in 0..<numberOfWords {
            let word = Game.getRandomWord(player, seed: i)
            player.addWord(word)
        }
        return player
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
        for word in player.words {
            words.append(ActiveWord(word: word, status: "?"))
        }
    }
    
    public func getPlayerByIndex(index: Int) -> Player {
        return players[index] // TODO: or nil in case of empty array or index > count
    }
    
    class func getRandomName(idx: Int) -> String {
        var name = ""
        name = "Player " + String(idx) // For dev purposes only!
        return name
    }
    
    // MARK: - Word
    
    class func getRandomWord(owner: Player, seed: Int) -> Word {
        var text = "Test\(seed)"// For dev purposes only!
        return Word(owner: owner, text: text)
    }
    
    // MARK: - Game
    
    public class func createRandomGame(numberOfPlayers: Int, numberOfWords: Int) -> Game {
        var newRandomGame = Game(numberOfPlayers: numberOfPlayers, words: numberOfWords)
        
        for idx in 2...numberOfPlayers {
            let newPlayer = newRandomGame.getNewPlayer(idx, numberOfWords: numberOfWords)
            newRandomGame.addPlayer(newPlayer)
        }
        
        return newRandomGame
    }
    
}