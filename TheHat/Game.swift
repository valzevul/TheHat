//
//  Game.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

class Game {
    
    var players = [Player]()
    let rounds: Int
    
    init(rounds: Int) {
        
        self.rounds = rounds
    }
    
    func addPlayer(player: Player) {
        players.append(player)
    }
    
    
}