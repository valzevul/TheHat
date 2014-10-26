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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsSourceTextField.delegate = self
        
        // TODO: Game() object
        gameObject = Game.createRandomGame(10, numberOfWords: 10)
        tSystem = TournamentSystem(game: gameObject!)
        lSettings = LocalSettings(gameType: gameTypeSegmentedControl.selectedSegmentIndex, wordsSource: wordsSourceTextField.text!)
        
    }
    
    @IBAction func gameTypeChanged(sender: UISegmentedControl) {
        switch gameTypeSegmentedControl.selectedSegmentIndex
            {
                case 0:
                    lSettings!.gameType = 0
                case 1:
                    lSettings!.gameType = 1
                case 2:
                    lSettings!.gameType = 2
                default:
                    break;
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        lSettings!.wordsSource = textField.text
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showNewRoundInfo") {
            var startGameVC = segue.destinationViewController as ListOfPlayersTableViewController;
            startGameVC.gameObject = gameObject
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        }
    }
}
