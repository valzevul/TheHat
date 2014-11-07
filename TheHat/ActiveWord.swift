//
//  ActiveWord.swift
//  TheHat
//
//  Created by Vadim Drobinin on 27/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation


public class ActiveWord: Word {
    
    private var status: String = "" // ?, OK or Failed
    private var guessedTime = 0 // For statistics, sec
    private var attemptsNumber = 0 // For statistics, attempts
    
    // MARK: - Initializers
    
    init(owner: Player, text: String, status: String) {
        super.init(owner: owner, text: text)
        self.status = status
    }
    
    init(word: Word, status: String) {
        super.init(owner: word.getOwner(), text: word.getText())
        self.status = status
    }
    
    // MARK: - Status
    
    func getStatus() -> String {
        return status
    }
    func changeStatus(status: String) {
        self.status = status
    }
    
    // MARK: - Statistics
    
    func getTime() -> Int {
        return guessedTime
    }
    func incTime(time: Int) {
        guessedTime += time
    }
    
    func getAttemptsNumber() -> Int {
        return attemptsNumber
    }
    func incAttemptsNumber() {
        attemptsNumber += 1
    }
}