//
//  SettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 25/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Settings Fields
    
    @IBOutlet weak var showTutorialSwitch: UISwitch!
    @IBOutlet weak var playersNameFIeld: UITextField!
    @IBOutlet weak var difficultnessSlider: UISlider!
    
    @IBOutlet weak var playersNumberStepper: UIStepper!
    @IBOutlet weak var wordsPerPlayerStepper: UIStepper!
    @IBOutlet weak var gameTimeStepper: UIStepper!
    @IBOutlet weak var additionalTimeStepper: UIStepper!
    
    @IBOutlet weak var playersNumberLabel: UILabel!
    @IBOutlet weak var playersWordsLabel: UILabel!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var additionalTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersNameFIeld.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
    }
    
    // MARK: - Settings Loading
    
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

    @IBAction func PlayersNumberValueChanged(sender: UIStepper) {
        playersNumberLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func WordsNumberValueChanged(sender: UIStepper) {
        playersWordsLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func GameTimeValueChanged(sender: UIStepper) {
        gameTimeLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func AdditionalTimeValueChanged(sender: UIStepper) {
        additionalTimeLabel.text = "\(Int(sender.value))"
        
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func tutorialSwitchValueDidChanged(sender: UISwitch) {
        sender.resignFirstResponder()
        NSUserDefaults.standardUserDefaults().setValue(sender.on, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func diffSliderValueDidChanged(sender: UISlider) {
        sender.resignFirstResponder()
        NSUserDefaults.standardUserDefaults().setValue(sender.value, forKey:Settings.keys[sender.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder();
        NSUserDefaults.standardUserDefaults().setValue(textField.text, forKey:Settings.keys[textField.tag])
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
