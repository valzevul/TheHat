//
//  StartGameViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController, RoundSettingsDelegate {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var previousPairResultLabel: UILabel!
    @IBOutlet weak var wordsLeftLabel: UILabel!
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerBLabel: UILabel!
    
    var tSystem: TournamentSystem?
    var currentPair: (Player, Player)?
    var lSettings: LocalSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (tSystem != nil) {
            
            tSystem!.currentActiveWords = [] // Wipe previous played words

            self.navigationItem.title = "Round \(tSystem!.playedRoundsNumber + 1)"
            wordsLeftLabel.text = "Words left: \(tSystem!.wordsLeft())"
            
            currentPair = tSystem!.getNextPair()
            playerALabel.text = currentPair!.0.getName()
            playerBLabel.text = currentPair!.1.getName()
            
            if let prevResult = tSystem!.getPreviousResult() {
                previousPairResultLabel.text = "Previous result: \(prevResult)"
                tSystem!.clean()
            }
        }
        
    }
    
    // MARK: Settings Changed
    
    func roundSettingsDidChanged(controller: CurrentRoundSettingsTableViewController, firstName: String, secondName: String) {
        currentPair!.0.setName(firstName)
        currentPair!.1.setName(secondName)
        
        playerALabel.text = currentPair!.0.getName()
        playerBLabel.text = currentPair!.1.getName()
    }

    @IBAction func playButtonAction(sender: UIButton) {
    }
    @IBAction func settingsButtonAction(sender: UIBarButtonItem) {
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "startNewRound") {
            var gameRoundVC = segue.destinationViewController as GameRoundViewController;
            gameRoundVC.tSystem = tSystem
            gameRoundVC.lSettings = lSettings
        }
        if (segue.identifier == "RoundSettingsSegue") {
            var roundSettingsVC = segue.destinationViewController as CurrentRoundSettingsTableViewController;
            roundSettingsVC.delegate = self
            roundSettingsVC.tSystem = tSystem
        }
    }

}
