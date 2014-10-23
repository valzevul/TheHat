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
    
    var gameObject: Game
    
    init(game: Game) {
        gameObject = game
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
    
    func finishCurrentRound() {
        
    }
    
}