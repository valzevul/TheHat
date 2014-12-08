//
//  SettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 25/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// CLass for settings table view controller
class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Settings Fields
    
    /// Switch determines to show the tutorial every run or not to show
    @IBOutlet weak var showTutorialSwitch: UISwitch!
    
    /// Default player's name
    @IBOutlet weak var playersNameFIeld: UITextField!
    
    /// Level of difficultness
    @IBOutlet weak var difficultnessSlider: UISlider!
    
    /// Number of players
    @IBOutlet weak var playersNumberStepper: UIStepper!
    
    /// Number of words per player
    @IBOutlet weak var wordsPerPlayerStepper: UIStepper!
    
    /// Game time
    @IBOutlet weak var gameTimeStepper: UIStepper!
    
    /// Additional game time
    @IBOutlet weak var additionalTimeStepper: UIStepper!
    
    /// NUmber of players label
    @IBOutlet weak var playersNumberLabel: UILabel!
    
    /// Number of words per player label
    @IBOutlet weak var playersWordsLabel: UILabel!
    
    /// Game time label
    @IBOutlet weak var gameTimeLabel: UILabel!
    
    /// Additional game time label
    @IBOutlet weak var additionalTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersNameFIeld.delegate = self
    }
    
    /**
        Loads global settings.
        
        :param: animated Bool
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
    }
    
    // MARK: - Settings Loading
    
    /**
        Loads global settings, updates all labels from the User's Defaults.
    */
    func loadSettings() {
        let namePreference = NSUserDefaults.standardUserDefaults()
        
        if let tutorial = namePreference.stringForKey("showTutorial") {
            if (tutorial == "1") {
                showTutorialSwitch.setOn(true, animated: true)
            } else {
                showTutorialSwitch.setOn(false, animated: true)
            }
        }
        
        if let pName = namePreference.stringForKey("playersName") {
            playersNameFIeld.text = pName
        }
        if let pNumber = namePreference.stringForKey("playersNumber") {
            playersNumberStepper.value = (pNumber as NSString).doubleValue
            playersNumberLabel.text = "\((pNumber as NSString).integerValue)"
        }
        if let diff = namePreference.stringForKey("difficultness") {
            difficultnessSlider.value = (diff as NSString).floatValue
        }
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTimeStepper.value = (gTime as NSString).doubleValue
            gameTimeLabel.text = "\((gTime as NSString).integerValue)"
        }
        if let aTime = namePreference.stringForKey("additionalTime") {
            additionalTimeStepper.value = (aTime as NSString).doubleValue
            additionalTimeLabel.text = "\((aTime as NSString).integerValue)"
        }
        if let pWords = namePreference.stringForKey("playerWords") {
            wordsPerPlayerStepper.value = (pWords as NSString).doubleValue
            playersWordsLabel.text = "\((pWords as NSString).integerValue)"
        }
    }
    
    // MARK: - Settings Saving

    /**
        Updates number of players.
        
        :param: sender UIStepper
    */
    @IBAction func PlayersNumberValueChanged(sender: UIStepper) {
        playersNumberLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
        Updates settings if number of words per player has changed.
        
        :param: sender UIStepper
    */
    @IBAction func WordsNumberValueChanged(sender: UIStepper) {
        playersWordsLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
        Updates settings if game time has changed.
        
        :param: sender UIStepper
    */
    @IBAction func GameTimeValueChanged(sender: UIStepper) {
        gameTimeLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
        Updates settings if additional time has changed.
    
        :param: sender UIStepper
    */
    @IBAction func AdditionalTimeValueChanged(sender: UIStepper) {
        additionalTimeLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
        Updates settings if tutorial's status has changed.
        
        :param: sender UISwitch
    */
    @IBAction func tutorialSwitchValueDidChanged(sender: UISwitch) {
        sender.resignFirstResponder()
        NSUserDefaults.standardUserDefaults().setValue(sender.on, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
        Updates settings if difficultness has changed.
        
        :param: sender UISlider
    */
    @IBAction func diffSliderValueDidChanged(sender: UISlider) {
        sender.resignFirstResponder()
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    /**
        Updates settings if some of text fields has changed.
        
        :param: sender UITextField
    */
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "") {
            textField.resignFirstResponder();
            NSUserDefaults.standardUserDefaults().setValue(textField.text, forKey:Settings.keys[textField.tag])
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
