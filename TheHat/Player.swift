//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

class Player {
    
    var words = [Word]()
    var name: String?
    
    init(name: String) {
        self.name = name
    }
    
    func addWord(word: Word) {
        words.append(word)
    }
}

