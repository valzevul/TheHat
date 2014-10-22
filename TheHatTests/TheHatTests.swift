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
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
            if (player.name == "") {
                isNameEmpty = true
            }
        }
        
        XCTAssertEqual(false, isNameEmpty, "Some players has empty names")
    }
    
    // MARK: - Tests for Word
    
    func testWordOwner() {
        let newPlayer = Player(name: "Tester")
        let newWord = Word(owner: newPlayer, text: "Test")
        
        let owner = newWord.getOwner()
        XCTAssertEqual(owner.name!, newPlayer.name!, "Players are different")
    }
    
    func testWordText() {
        let newPlayer = Player(name: "Tester")
        let newWord = Word(owner: newPlayer, text: "Test")
        
        let text = newWord.getText()
        XCTAssertEqual(text, "Test", "Players are different")
    }
}
