//
//  TournamentSystem.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

/// Tournament Systems maintains rounds and operations for interaction with them.
class TournamentSystem {
    
    /// Game object with players and Active Words
    let gameObject: Game
    
    /// First player in pair
    var playerIdx = 0
    
    /// Number of played rounds
    var playedRoundsNumber: Int = 0
    
    /// Words played in the current round
    var currentActiveWords = [ActiveWord]()
    
    /// Results of the current round
    var currentResult: Int = 0
    
    /// Current pair of Players
    var currentPair: (Player, Player)?
    
    
    /**
        Initializes a new Tournament System object.
    
        :param: game Game object
        :returns: new Tournament System object with a link to the Game object.
    
    */
    init(game: Game) {
        gameObject = game
    }
    
    // MARK: - Words
    
    /**
        Returns number of words left in the game.

        :returns: Int number of words left in the game.
    */
    func wordsLeft() -> Int {
        return gameObject.wordsLeft
    }
    
    /**
        Returns a new Active word and removes it from the list of unguessed words.

        :returns: Active word or null if there is no more.
    */
    func getNewWord() -> ActiveWord? {
        if (gameObject.words.count > 0) {
            return gameObject.words.removeLast()
        } else {
            return nil
        }
    }
    
    /**
        Apply new results to statistics and update the list of active words with a new guessed now.
    
        :param: word Active Word which was guessed
    */
    func wordGuessed(word: ActiveWord) {
        currentResult += 1 // Number of words guessed by the pair
        (currentPair!.0).incScoreExplained()
        (currentPair!.1).incScoreGuessed()
        word.changeStatus(Constants.OK)
        currentActiveWords.append(word)
    }
    
    /**
        Apply new results to statistics and update the list of active words with a new failed now.
    
        :param: word Active Word which was failed
    */
    func wordFailed(word: ActiveWord) {
        word.changeStatus(Constants.F)
        currentActiveWords.append(word)
    }
    
    /**
        Apply new results to statistics and update the list of active words with a new missed now.
    
        :param: word Active Word which was missed
    */
    func wordMissed(word: ActiveWord) {
        if (word.getStatus() == Constants.M) { // If word is really missed, not failed
            gameObject.words.insert(word, atIndex: 0) // Returns it back to the list of words
            currentActiveWords.append(word)
        }
    }
    
    // MARK: - Players
    
    /**
        Generate a new pair of players for the game with a step of two.
    
        :returns: (Player, Player) tuple or nil if there is no new games
    */
    func getNextPair() -> (Player, Player)? { // Create new pair of players
        var player_1 = gameObject.getPlayerByIndex(playerIdx)
        var player_2 = gameObject.getPlayerByIndex(playerIdx + 1)
        
        playerIdx += 2
        if (playerIdx + 1 > gameObject.players.count) {
            playerIdx = 0 // Starts from the first player for the next "round" of rounds
        }
        
        currentPair = (player_1, player_2)
        return currentPair
    }
    
    // MARK: - Round
    
    /**
        Starts new round.
    */
    func startNextRound() {
        currentActiveWords = [ActiveWord]()
        playedRoundsNumber += 1
        var currentPair = getNextPair() // Or without "var", it depends // TODO: Change this structure
    }
    
    /**
        Returns a result of the previous round.
    
        :returns: Int result or nil if this is the first round
    */
    func getPreviousResult() -> Int? {
        return currentResult
    }
    
    /**
        Starts new round with wiping all previous results.
    */
    func clean() {
        currentResult = 0
    }
    
    /**
        Provides support of word's status change after the round.
    
        :param: word ActiveWord
        :param: status String?
    */
    func changeWordsStatus(word: ActiveWord, status: String?) {
        if (status == Constants.F) {
            wordFailed(word)
            (currentPair!.0).decScoreExplained()
            (currentPair!.1).decScoreGuessed()
            gameObject.removeWord(word)
        } else if (status == Constants.M) {
            wordMissed(word)
            (currentPair!.0).decScoreExplained()
            (currentPair!.1).decScoreGuessed()
        } else {
            wordGuessed(word)
            gameObject.removeWord(word)
        }
    }
    
    /**
    Returns list of players sorted by points and separated on teams.
    
    :returns: [Player] list
    */
    func getOverallResults() -> [Player] {
        var result: [Player] = gameObject.players
        result.sort { (a, b) -> Bool in
            return a.getOverallScore() > b.getOverallScore()
        }

        return result
    }
}