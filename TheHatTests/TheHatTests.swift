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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameNumberOfPlayers() {
        var gameObject: Game = Game.createRandomGame(10, numberOfWords: 10)
        var numberOfPlayers = gameObject.numberOfPlayers
        
        XCTAssertEqual(10, numberOfPlayers, "Number of players isn't equal to the expected")
    }
    
    func testGameAddPlayer() {
        var gameObject: Game = Game.createRandomGame(10, numberOfWords: 10)
        var numberOfPlayers = gameObject.numberOfPlayers
        
        var newPlayer = Player(name: "Test 1")
        gameObject.addPlayer(newPlayer)
        
        newPlayer = Player(name: "Test 2")
        gameObject.addPlayer(newPlayer)
        
        newPlayer = Player(name: "Test 3")
        gameObject.addPlayer(newPlayer)
        
        var newNumberOfPlayers = gameObject.numberOfPlayers
        
        XCTAssertEqual(numberOfPlayers + 3, newNumberOfPlayers, "Number of players isn't equal to the expected")
    }
    
    func testGameRandomNames() {
        var gameObject: Game = Game.createRandomGame(10, numberOfWords: 10)
        var isNameEmpty = false
        
        for player in gameObject.players {
            if (player.name == "") {
                isNameEmpty = true
            }
        }
        
        XCTAssertEqual(false, isNameEmpty, "Some players has empty names")
    }
    
}
