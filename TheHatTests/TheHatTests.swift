//
//  TheHatTests.swift
//  TheHatTests
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import XCTest

import TheHat

class TheHatTests: XCTestCase {
    
    let NUMBER_OF_PLAYERS = 10;
    let NUMBER_OF_WORDS = 10;
    
    var gameObject: Game?
    
    override func setUp() {
        super.setUp()
        
        gameObject = Game.createRandomGame(NUMBER_OF_PLAYERS, numberOfWords: NUMBER_OF_WORDS)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    // MARK: - Tests for Game
    
    func testGameNumberOfPlayers() {
        var numberOfPlayers = gameObject!.numberOfPlayers
        
        XCTAssertEqual(NUMBER_OF_PLAYERS, numberOfPlayers, "Number of players isn't equal to the expected")
    }
    
    func testGameGetPlayerByIndex() {
        var newPlayer = Player(name: "Test 1")
        var newWord = ImportedWord(text: "Test", description: "Lol", part_of_speech: "Noun", complexity: 50)
        newPlayer.addWord(newWord)
        newPlayer.addWord(newWord)
        gameObject!.addPlayer(newPlayer)
        
        var returnedPlayer = gameObject!.getPlayerByIndex(gameObject!.numberOfPlayers - 1)
        XCTAssertEqual(newPlayer.getName()!, returnedPlayer.getName()!)
    }
    
    func testGameAddPlayer() {
        var numberOfPlayers = gameObject!.numberOfPlayers
        
        var newPlayer = Player(name: "Test 1")
        gameObject!.addPlayer(newPlayer)
        
        newPlayer = Player(name: "Test 2")
        gameObject!.addPlayer(newPlayer)
        
        newPlayer = Player(name: "Test 3")
        gameObject!.addPlayer(newPlayer)
        
        var newNumberOfPlayers = gameObject!.numberOfPlayers
        
        XCTAssertEqual(numberOfPlayers + 3, newNumberOfPlayers, "Number of players isn't equal to the expected")
    }
    
    func testGameRandomNames() {
        var isNameEmpty = false
        
        for player in gameObject!.players {
            if (player.getName() == "") {
                isNameEmpty = true
            }
        }
        
        XCTAssertEqual(false, isNameEmpty, "Some players has empty names")
    }
    
    // MARK: - Tests for Word
    
    // MARK: - Tests for Tournament System
    
    func testTournamentSystemGetNewPair() {
        
        var ts = TournamentSystem(game: gameObject!)
        
        XCTAssertEqual(0, ts.currentResult)
        XCTAssertEqual(NUMBER_OF_PLAYERS * NUMBER_OF_WORDS, ts.wordsLeft())
        
    }
    
    // MARK: - Tests for Dictionary
    
    func testDictionaryShuffle() {
        
        var d = JSONDictionary(filename: "dict")
        
        var word = d.words[0].text
        
        d.words.shuffle()
        
        var newWord = d.words[0].text
        
        XCTAssertNotEqual(word, newWord)
    }

    
    // MARK: - Tests for all game process
    
    // TODO: Test for the full game imitation
    
    func testFullGameImitation() {
        
        // Initialize settings
        
        // Get data for the game
        let numberOfPlayers = 4
        let numberOfWords = 5
        
        // Create game object && add players with random words
        gameObject = Game.createRandomGame(numberOfPlayers, numberOfWords: numberOfWords)

        // Create tournament system object
        let tSystem = TournamentSystem(game: gameObject!)
        
        // While words in game
        while (tSystem.wordsLeft() > 0) {
        
            // Start new round
            tSystem.startNextRound()
            
            // While timer > -additionalTime
            for i in 1..<5 {
                if let currentWord = tSystem.getNewWord() {
                    println(currentWord.text)
                    if (i <= 3) {
                        tSystem.wordGuessed(currentWord)
                    } else {
                        tSystem.wordMissed(currentWord)
                    }
                }
            }
        
            // Show results
            for word in tSystem.currentGameWords {
                println("Word: \(word.text), status: \(word.status.status)")
            }
        }
        
        // Show overall results
        
        for player in tSystem.gameObject.players {
            
            println("\(player.getName()): \n\t score: \(player.getOverallScore())")
        }
        
        // Save to statistics
        
        // Clean all
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}