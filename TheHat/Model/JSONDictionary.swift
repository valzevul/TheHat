import Foundation

public class WordStatus {
    
    public enum Status {
        case Unknown, Guessed, Failed
    }
    
    public private(set) var attemptsNumber: Int
    public private(set) var guessedTime: Int
    public private(set) var status: Status
    
    init() {
        self.attemptsNumber = 0
        self.guessedTime = 0
        self.status = .Unknown
    }
    
    public func updateStatus(time: Int, isNewAttempt: Bool, status: Status) {
        if (isNewAttempt) {
            self.attemptsNumber += 1
        }
        self.guessedTime += time
        self.status = status
    }
}

public class ImportedWord {
    
    enum PartOfSpeech {
        case Noun, Verb, Adjective
    }
    
    public let text: String
    public let description: String
    public let complexity: Int
    private let part: PartOfSpeech
    
    init(text: String, description: String, part_of_speech: String, complexity: Int) {
        self.text =  text
        self.description = description
        self.complexity = complexity
        
        switch part_of_speech {
        case "Verb":
            self.part = .Verb
            break
        case "Adjective":
            self.part = .Adjective
            break
        default:
            self.part = .Noun
            break
        }
        
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}

public class GameWord: ImportedWord {
    public private(set) var owner: Player
    public private(set) var status: WordStatus
    
    init(owner: Player, word: ImportedWord) {
        self.owner = owner
        self.status = WordStatus()
        super.init(text: word.text, description: word.description, part_of_speech: "\(word.part)", complexity: word.complexity)
    }
    
    public func changeOwner(owner: Player) {
        self.owner = owner
    }
    
    public func getComplexity() -> String {
        if (self.complexity < Constants.EASY_POINTS) {
            return Constants.EASY
        } else if (self.complexity < Constants.NORMAL_POINTS) {
            return Constants.NORMAL
        } else if (self.complexity < Constants.DIFFICULT_POINTS) {
            return Constants.DIFFICULT
        } else if (self.complexity < Constants.HARD_POINTS) {
            return Constants.HARD
        } else {
            return Constants.UNKNOWN
        }
    }

}

public class JSONDictionary {
    public var words = [ImportedWord]()
    public let description: String
    
    init(filename: String) {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        let json = JSON(data: data!)
        
        description = json["description"].stringValue
        var w = json["words"].arrayValue
        for elem in w {
            var desc = elem["description"].stringValue
            var word = elem["word"].stringValue
            var part = elem["part_of_speech"].stringValue
            var comp = elem["complexity"].intValue
            
            var newWord = ImportedWord(text: word, description: desc, part_of_speech: part, complexity: comp)
            words.append(newWord)
        }
    }
    
    public func getNewWord() -> ImportedWord? {
        return words.last
    }
}