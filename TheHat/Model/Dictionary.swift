//
//  Dictionary.swift
//  TheHat
//
//  Created by Vadim Drobinin on 24/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation


/// Extension for the Array class to implement the random shuffle sort.
extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}


/// Dictionary class to operate with parsed from a file words
class Dictionary {
    
    /// File to be parsed
    let filename: String
    
    /// List of words from the file
    var textWords = [String]() // Words from file
    
    /// Number of processed words
    var wordsReturned = 0
    
    /**
        Initializes Dictionary object with name of the file to be parsed.
    
        :param: filename String name of the file
    */
    init(filename: String) {
        self.filename = filename
    }
    
    /**
        Get new word from the list.
    
        :return: String word from file
    */
    func getNewWord() -> String? { // Returns new word
        wordsReturned += 1
        return getNewWordByIndex(wordsReturned - 1)
    }
    
    /**
        Returns new word by index (i.e for the random shuffle)
    
        :param: index Int index of the word
        :return: String word or nil if the index is out of bound
    */
    func getNewWordByIndex(index: Int) -> String? {
        if (index < 0 || index >= textWords.count) {
            return nil
        }
        return textWords[index]
    }
    
    /**
        Parses words from a file and shuffle them in the list.
    */
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
        
        textWords.shuffle()
    }
    
}