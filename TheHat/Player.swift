//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

public class Player {
    
    var words = [Word]()
    var name: String?
    
    var scoreExplained = 0
    var scoreGuessed = 0
    
    init(name: String) {
        self.name = name
    }
    
    func addWord(word: Word) {
        words.append(word)
    }
}

