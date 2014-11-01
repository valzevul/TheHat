//
//  Game.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

public class Game {
    
    var players = [Player]()
    public var words = [ActiveWord]() // Words with statuses and statistics
    
    var privateNumberOfPlayers: Int
    
    let numberOfWords: Int
    let numberOfWordsLeft: Int
    
    public var wordsLeft: Int {
        get {
            return numberOfWordsLeft
        }
    }
    
    public var numberOfPlayers: Int {
        get {
            return players.count
        }
    }
    
    init(numberOfPlayers: Int, numberOfWords: Int) {
        self.numberOfWords = numberOfWords
        self.numberOfWordsLeft = numberOfWords * numberOfPlayers
        self.privateNumberOfPlayers = numberOfPlayers
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
        for word in player.words {
            words.append(ActiveWord(word: word, status: "?"))
        }
    }
    
    class func getRandomName(idx: Int) -> String {
        var name = ""
        name = "Player " + String(idx) // For dev purposes only!
        return name
    }
    
    class func getRandomWord(owner: Player, seed: Int) -> Word {
        var text = "Test\(seed)"// For dev purposes only!
        return Word(owner: owner, text: text)
    }
    
    public class func createRandomGame(numberOfPlayers: Int, numberOfWords: Int) -> Game {
        var newRandomGame = Game(numberOfPlayers: numberOfPlayers, numberOfWords: numberOfWords)
        
        for idx in 1...numberOfPlayers {
            var randomName = getRandomName(idx)
            var newPlayer = Player(name: randomName)
            
            for cntr in 1...numberOfWords {
                var randomWord = getRandomWord(newPlayer, seed: cntr)
                newPlayer.addWord(randomWord)
            }
            
            newRandomGame.addPlayer(newPlayer)
        }
        
        return newRandomGame
    }

    public func getPlayerByIndex(index: Int) -> Player {
        return players[index] // TODO: or nil in case of empty array or index > count
    }
    
}