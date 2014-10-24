//
//  Dictionary.swift
//  TheHat
//
//  Created by Vadim Drobinin on 24/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

class Dictionary {
    
    var textWords = ["A", "B", "C", "D", "E", "F", "G", "H"]
    
    func getNewWordByIndex(index: Int) -> String? {
        if (index < 0 || index >= textWords.count) {
            return nil
        }
        return textWords[index]
    }
    
    func shuffle() {
        sort(&textWords) {(_, _) in arc4random() % 2 == 0}
    }
    
}