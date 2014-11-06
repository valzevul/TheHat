//
//  CurrentRoundSettingsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

protocol RoundSettingsDelegate {
    
    func roundSettingsDidChanged(controller: CurrentRoundSettingsTableViewController, firstName: String, secondName: String)
}

class CurrentRoundSettingsTableViewController: UITableViewController {

    var delegate:RoundSettingsDelegate? = nil
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    
    @IBOutlet weak var firstPlayerNameTextField: UITextField!
    @IBOutlet weak var secondPlayerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerNameTextField.text = tSystem!.currentPair!.0.name
        secondPlayerNameTextField.text = tSystem!.currentPair!.1.name

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func didFirstPlayerNameEdit(sender: UITextField) {
        tSystem!.currentPair!.0.name = firstPlayerNameTextField.text
        if (delegate != nil) {
            delegate!.roundSettingsDidChanged(self, firstName: firstPlayerNameTextField.text, secondName: secondPlayerNameTextField.text)
        }
    }
    
    
    @IBAction func didSecondPlayerNameEdit(sender: UITextField) {
        tSystem!.currentPair!.1.name = secondPlayerNameTextField.text
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
