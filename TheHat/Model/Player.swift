//
//  Word.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import Foundation
import UIKit

public class Player {
    
    private var words = [Word]()
    private var name: String?
    private var index: Int?
    private var image: UIImage? // In case of import from address book
    
    private var scoreExplained = 0
    private var scoreGuessed = 0
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    func addWord(word: Word) {
        self.words.append(word)
    }
    
    func setIndex(index: Int) {
        if (index >= 0) {
            self.index = index
        }
    }
    
    func getWords() -> [Word] {
        return words
    }
    
    func getOverallScore() -> Int {
        return self.scoreExplained + self.scoreGuessed
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func incScoreExplained() {
        self.scoreExplained += 1
    }
    
    func incScoreGuessed() {
        self.scoreGuessed += 1
    }
    
    func getImage() -> UIImage? {
        return self.image
    }
}