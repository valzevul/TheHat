//
//  CurrentRoundSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Delegete for changed settings
protocol RoundSettingsDelegate {
    
    /**
        Notify about changed settings of the current round.
        
        :param: controller CurrentRoundSettingsTableViewController
        :param: firstName String first player's name
        :param: secondName String second player's name
    */
    func roundSettingsDidChanged(controller: CurrentRoundSettingsTableViewController, firstName: String, secondName: String)
}

/// Current round settings
class CurrentRoundSettingsTableViewController: UITableViewController {
    
    /// TextFiled with the name of the first player
    @IBOutlet weak var firstPlayerNameTextField: UITextField!
    
    /// TextFiled with the name of the second player
    @IBOutlet weak var secondPlayerNameTextField: UITextField!
    
    /// Delegate for the round settings
    var delegate:RoundSettingsDelegate? = nil

    /// Tournament System object
    var tSystem: TournamentSystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update fields
        firstPlayerNameTextField.text = tSystem!.currentPair!.0.getName()
        secondPlayerNameTextField.text = tSystem!.currentPair!.1.getName()
    }
    
    // MARK: - Process Settings
    
    /**
        Notify delegate about changes in the first player's name.
        
        :param: sender UITextField
    */
    @IBAction func didFirstPlayerNameEdit(sender: UITextField) {
        
        sender.text = sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if (!sender.text.isEmpty) {
            tSystem!.currentPair!.0.setName(firstPlayerNameTextField.text)
            if (delegate != nil) {
                delegate!.roundSettingsDidChanged(self, firstName: firstPlayerNameTextField.text, secondName: secondPlayerNameTextField.text)
            }
        }
    }
    
    /**
        Notify delegate about changes in the second player's name.
    
        :param: sender UITextField
    */
    @IBAction func didSecondPlayerNameEdit(sender: UITextField) {
        
        sender.text = sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if (!sender.text.isEmpty) {
            tSystem!.currentPair!.1.setName(secondPlayerNameTextField.text)
            if (delegate != nil) {
                delegate!.roundSettingsDidChanged(self, firstName: firstPlayerNameTextField.text, secondName: secondPlayerNameTextField.text)
            }
        }
    }
}
