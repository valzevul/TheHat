//
//  TournamentSystem.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

class TournamentSystem {
    
    let PLAYERS_IN_ROUND = 2
    let gameObject: Game
    
    var playerIdx = 0
    var playedRoundsNumber: Int = 0
    
    var currentActiveWords = [ActiveWord]() // Current round played (!) words
    var currentResult: Int = 0
    var currentPair: (Player, Player)?
    
    init(game: Game) {
        gameObject = game
    }
    
    // MARK: - Words
    
    func wordsLeft() -> Int {
        return gameObject.wordsLeft
    }
    
    func getNewWord() -> ActiveWord? { // Returns new word and remove it from the list
        if (gameObject.words.count > 0) {
            return gameObject.words.removeLast()
        } else {
            return nil
        }
    }
    
    func shuffleWords() {
        //
    }
    
    func wordGuessed(word: ActiveWord) {
        currentResult += 1
        (currentPair!.0).incScoreExplained()
        (currentPair!.1).incScoreGuessed()
        word.changeStatus("OK")
        currentActiveWords.append(word)
    }
    
    func wordFailed(word: ActiveWord) {
        word.changeStatus("F")
        currentActiveWords.append(word)
        finishCurrentRound()
    }
    
    func wordMissed(word: ActiveWord) {
        if (word.getStatus() == "?") {
            
            gameObject.words.insert(word, atIndex: 0)
            currentActiveWords.insert(word, atIndex: 0)
        }
    }
    
    // MARK: - Players
    
    func getNextPair() -> (Player, Player)? { // Create new pair of players
        var player_1 = gameObject.getPlayerByIndex(playerIdx)
        var player_2 = gameObject.getPlayerByIndex(playerIdx + 1)
        
        playerIdx += PLAYERS_IN_ROUND
        if (playerIdx + 1 > gameObject.players.count) {
            playerIdx = 0
        }
        
        currentPair = (player_1, player_2)
        return currentPair
    }
    
    // MARK: - Round
    
    func startNextRound() { // Imitate new game round
        currentActiveWords = [ActiveWord]()
        playedRoundsNumber += 1
        var currentPair = getNextPair()
        shuffleWords()
    }
    
    func finishCurrentRound() {
        // ???
    }
    
    func getPreviousResult() -> Int? {
        return currentResult
    }
    
    func clean() {
        currentResult = 0
        shuffleWords()
    }
}