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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersNameFIeld.delegate = self
        playersNumberField.delegate = self
        gameTimeField.delegate = self
        additionalTimeField.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) { //Handle the text changes here
        println(textField.text); //the textView parameter is the textView where text was changed
    }
    
}
