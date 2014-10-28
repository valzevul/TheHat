//
//  ActiveWord.swift
//  TheHat
//
//  Created by Vadim Drobinin on 27/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation


public class ActiveWord: Word {
    
    private var status: String = ""
    public var guessedTime: Int? // For statistics
    public var attemptsNumber: Int? // For statistics
    
    init(owner: Player, text: String, status: String) {
        super.init(owner: owner, text: text)
        self.status = status
    }
    
    init(word: Word, status: String) {
        super.init(owner: word.getOwner(), text: word.getText())
        self.status = status
        
    }
    
    func changeStatus(status: String) {
        self.status = status
    }
    
    func getStatus() -> String {
        return status
    }

}