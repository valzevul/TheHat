//
//  SettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 25/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var showTutorialSwitch: UISwitch!
    @IBOutlet weak var playersNameFIeld: UITextField!
    @IBOutlet weak var playersNumberField: UITextField!
    @IBOutlet weak var difficultnessSlider: UISlider!
    @IBOutlet weak var gameTimeField: UITextField!
    @IBOutlet weak var additionalTimeField: UITextField!
    @IBOutlet weak var wordsPerPlayerField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersNameFIeld.delegate = self
        playersNumberField.delegate = self
        gameTimeField.delegate = self
        additionalTimeField.delegate = self
        wordsPerPlayerField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
    }
    
    func loadSettings() {
        var namePreference = NSUserDefaults.standardUserDefaults()
        
        if let tutorial = namePreference.stringForKey("showTutorial") {
            var switchOn = true
            if (tutorial != "true") {
                let switchOn = false
            }
            showTutorialSwitch.setOn(switchOn, animated: true)
        }
        
        if let pName = namePreference.stringForKey("playersName") {
            playersNameFIeld.text = pName
        }
        if let pNumber = namePreference.stringForKey("playersNumber") {
            playersNumberField.text = pNumber
        }
        if let diff = namePreference.stringForKey("difficultness") {
            difficultnessSlider.value = (diff as NSString).floatValue
        }
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTimeField.text = gTime
        }
        if let aTime = namePreference.stringForKey("additionalTime") {
            additionalTimeField.text = aTime
        }
        if let pWords = namePreference.stringForKey("playerWords") {
            wordsPerPlayerField.text = pWords
        }
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
