//
//  NewGameSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the local settings before a new game
class NewGameSettingsTableViewController: UITableViewController, UITextFieldDelegate {

    /// Segmented control for the game type (pair-to-pair, random game, etc)
    @IBOutlet weak var gameTypeSegmentedControl: UISegmentedControl!
    
    /// Source of a words' package
    @IBOutlet weak var wordsSourceTextField: UITextField!
    
    /// Game object
    var gameObject: Game?
    
    /// Tournament System object
    var tSystem: TournamentSystem?
    
    /// Local settings object
    var lSettings: LocalSettings?
    
    /// Loaded global settings
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsSourceTextField.delegate = self
        
        if let pWords = namePreference.stringForKey("playerWords") {
            if let pNumber = namePreference.stringForKey("playersNumber") {
                gameObject = Game.createRandomGame(pNumber.toInt()!, numberOfWords: pWords.toInt()!)
            }
        } else {
            gameObject = Game.createRandomGame(4, numberOfWords: 10)
        }
        
        // Create Tournament System and Local Settings objects
        
        tSystem = TournamentSystem(game: gameObject!)
        lSettings = LocalSettings(gameType: gameTypeSegmentedControl.selectedSegmentIndex, wordsSource: wordsSourceTextField.text!)
        
    }
    
    // MARK: - Settings Savings
    
    /**
        Changes game type and updates local settings.
        
        :param: sender UISegmentedControl object
    */
    @IBAction func gameTypeChanged(sender: UISegmentedControl) {
        lSettings!.changeGameType(gameTypeSegmentedControl.selectedSegmentIndex)
    }
    
    /**
        Changes words' source and updates local settings.
        
        :param: textField UITextField object
    */
    func textFieldDidEndEditing(textField: UITextField) {
        lSettings!.changeWordsSource(textField.text)
    }
    
    // MARK: - Segue
    
    /**
        Prepares for the game.
        
        :param: UIStoryboardSegue object
        :param: sender AnyObject!
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showNewRoundInfo") {
            var startGameVC = segue.destinationViewController as ListOfPlayersTableViewController;
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        }
    }
}
