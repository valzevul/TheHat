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
    var privateNumberOfPlayers: Int
    
    let numberOfWords: Int
    
    
    public var numberOfPlayers: Int {
        get {
            return players.count
        }
    }
    
    init(numberOfPlayers: Int = 10, numberOfWords: Int = 10) {
        self.numberOfWords = numberOfWords
        self.privateNumberOfPlayers = numberOfPlayers
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
    }
    
    class func getRandomName(idx: Int) -> String {
        return String(idx) // For dev purposes only
    }
    
    class func getRandomWord(owner: Player, seed: Int) -> Word {
        var text = "Test\(seed)"// For dev purposes only
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

}