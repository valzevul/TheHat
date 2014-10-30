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
    
    var currentActiveWords = [ActiveWord]() // Current round played (!) words
    
    var playedRoundsNumber: Int = 0
    var currentResult: Int = 0
    
    var currentPair: (Player, Player)?
    let gameObject: Game
    
    
    init(game: Game) {
        gameObject = game
    }
    
    func wordsLeft() -> Int {
        return gameObject.wordsLeft
    }
    
    func getNewWord() -> ActiveWord {
        return gameObject.words.removeLast()
    }
    
    func getNextPair() -> (Player, Player)? {
        
        var player_1 = gameObject.getPlayerByIndex(player1_idx)
        var player_2 = gameObject.getPlayerByIndex(player2_idx)
        
        player1_idx += 2
        player2_idx += 2
        if (player2_idx > gameObject.players.count) {
            player1_idx = 0
            player2_idx = 1
        }
        
        currentPair = (player_1, player_2)
        return currentPair
    }
    
    func startNextRound() {
        playedRoundsNumber += 1
        var currentPair = getNextPair()
        shuffleWords()
    }
    
    func clean() {
        currentResult = 0
    }
    
    func shuffleWords() {
        
    }
    
    func wordGuessed(word: ActiveWord) {
        currentResult += 1
        (currentPair!.0).scoreExplained += 1
        (currentPair!.1).scoreGuessed += 1
        word.changeStatus("OK")
        currentActiveWords.append(word)
    }

    func wordFailed(word: ActiveWord) {
        word.changeStatus("F")
        currentActiveWords.append(word)
        finishCurrentRound()
    }
    
    func wordMissed(word: ActiveWord) {
        gameObject.words.append(word)
        currentActiveWords.append(word)
    }
    
    func finishCurrentRound() {
        // ???
    }
    
    func getPreviousResult() -> Int? {
        return currentResult
    }
}