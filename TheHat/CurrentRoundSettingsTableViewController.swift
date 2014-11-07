//
//  CurrentRoundSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

protocol RoundSettingsDelegate { // Delegete for changed settings
    
    func roundSettingsDidChanged(controller: CurrentRoundSettingsTableViewController, firstName: String, secondName: String)
}

class CurrentRoundSettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var firstPlayerNameTextField: UITextField!
    @IBOutlet weak var secondPlayerNameTextField: UITextField!
    
    var delegate:RoundSettingsDelegate? = nil
    var tSystem: TournamentSystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerNameTextField.text = tSystem!.currentPair!.0.name
        secondPlayerNameTextField.text = tSystem!.currentPair!.1.name
    }
    
    // MARK: - Process Settings
    
    @IBAction func didFirstPlayerNameEdit(sender: UITextField) {
        tSystem!.currentPair!.0.name = firstPlayerNameTextField.text
        if (delegate != nil) {
            delegate!.roundSettingsDidChanged(self, firstName: firstPlayerNameTextField.text, secondName: secondPlayerNameTextField.text)
        }
    }
    
    @IBAction func didSecondPlayerNameEdit(sender: UITextField) {
        tSystem!.currentPair!.1.name = secondPlayerNameTextField.text
        if (delegate != nil) {
            delegate!.roundSettingsDidChanged(self, firstName: firstPlayerNameTextField.text, secondName: secondPlayerNameTextField.text)
        }
    }
}
