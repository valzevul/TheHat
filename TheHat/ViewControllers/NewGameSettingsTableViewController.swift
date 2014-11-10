//
//  NewGameSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class NewGameSettingsTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var gameTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var wordsSourceTextField: UITextField!
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
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
    
    @IBAction func gameTypeChanged(sender: UISegmentedControl) {
        lSettings!.gameType = gameTypeSegmentedControl.selectedSegmentIndex
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        lSettings!.wordsSource = textField.text
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showNewRoundInfo") {
            var startGameVC = segue.destinationViewController as ListOfPlayersTableViewController;
            startGameVC.gameObject = gameObject
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        }
    }
}
