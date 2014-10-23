//
//  TournamentSystem.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

class TournamentSystem {
    
    var player1_idx: Int = 0
    var player2_idx: Int = 1
    
    var playedRoundsNumber: Int = 0
    var currentResult: Int = 0
    
    let gameObject: Game
    
    init(game: Game) {
        gameObject = game
    }
    
    func wordsLeft() -> Int {
        return gameObject.wordsLeft
    }
    
    func getNewWord() -> Word {
        return gameObject.words.removeLast()
    }
    
    func getNextPair() -> (Player, Player) {
        
        var player_1 = gameObject.getPlayerByIndex(player1_idx)
        var player_2 = gameObject.getPlayerByIndex(player2_idx)
        
        player1_idx += 2
        player2_idx += 3
        
        return (player_1, player_2)
    }
    
    func startNextRound() {
        playedRoundsNumber += 1
        var currentPair = getNextPair()
        shuffleWords()
    }
    
    func shuffleWords() {
        
    }
    
    func wordGuessed() {
        currentResult += 1
    }

    func wordFailed() {
        // ???
    }
    
    func wordMissed(word: Word) {
        gameObject.words.append(word)
    }
    
    func finishCurrentRound() {
        // ???
    }
    
    func getPreviousResult() -> Int? {
        return currentResult
    }
}