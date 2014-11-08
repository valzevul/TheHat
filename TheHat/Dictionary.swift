//
//  Dictionary.swift
//  TheHat
//
//  Created by Vadim Drobinin on 24/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation

extension Array
    {
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

class Dictionary {
    
    var textWords = [String]()
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func getNewWordByIndex(index: Int) -> String? {
        if (index < 0 || index >= textWords.count) {
            return nil
        }
        return textWords[index]
    }
    
    func shuffle() {
        textWords = sorted(textWords) {_, _ in arc4random() % 2 == 0}
    }
    
    func parse() {
        
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(filename, ofType: "txt")
        
        var error:NSError?
        if let content = NSString.stringWithContentsOfFile(path!, encoding: NSUTF8StringEncoding, error: &error) {
            var array = content.componentsSeparatedByString("\n")
            
            for elem in array {
                textWords.append(toString(elem.componentsSeparatedByString(" ")[0])) // For now we forgot about "weight" of the word
            }
        }
        
        println(textWords)
    }
    
}