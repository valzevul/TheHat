//
//  NewGameSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the local settings before a new game
class NewGameSettingsTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var packagesPicker: UIPickerView!
    
    /// Game object
    var gameObject: Game?
    
    /// Tournament System object
    var tSystem: TournamentSystem?
    
    /// Local settings object
    var lSettings: LocalSettings?
    
    /// Loaded global settings
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    let pickerData = [["russian", "Russian dictionary", "Casual Russian words"], ["english", "English dictionary", "Casual English words"]]
    
    @IBOutlet weak var packageDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.packagesPicker.dataSource = self
        self.packagesPicker.delegate = self
        packageDescription.text = pickerData[0][2]
    }
    
    // MARK: - Settings Savings
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row][1]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        packageDescription.text = pickerData[packagesPicker.selectedRowInComponent(0)][2]
        
    }
    
    // MARK: - Segue
    
    /**
        Prepares for the game.
        
        :param: UIStoryboardSegue object
        :param: sender AnyObject!
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showNewRoundInfo") {
            // Create Tournament System and Local Settings objects
            lSettings = LocalSettings(gameType: 0, wordsSource: pickerData[packagesPicker.selectedRowInComponent(0)][0])
            if let pWords = namePreference.stringForKey("playerWords") {
                if let pNumber = namePreference.stringForKey("playersNumber") {
                    gameObject = Game.createRandomGame(pNumber.toInt()!, numberOfWords: pWords.toInt()!, dict: lSettings!.wordsSource!)
                }
            } else {
                gameObject = Game.createRandomGame(4, numberOfWords: 10, dict: lSettings!.wordsSource!)
            }
            tSystem = TournamentSystem(game: gameObject!)
            
            var startGameVC = segue.destinationViewController as! ListOfPlayersTableViewController;
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        }
    }
}
