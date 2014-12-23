//
//  StartGameViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the start game view with previous round's results and round settings.
class StartGameViewController: BaseViewController, RoundSettingsDelegate {

    /// Start game button
    @IBOutlet weak var playButton: UIButton!
    
    /// Round settings button
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    /// Label with previous results or 0 in case of the first round
    @IBOutlet weak var previousPairResultLabel: UILabel!
    
    /// Number of words in the "Hat"
    @IBOutlet weak var wordsLeftLabel: UILabel!
    
    /// First player's name
    @IBOutlet weak var playerALabel: UILabel!
    
    /// Second player's name
    @IBOutlet weak var playerBLabel: UILabel!
    
    /// Tournament system object
    var tSystem: TournamentSystem?
    
    /// Local settings object
    var lSettings: LocalSettings?

    /// Pair of players for the current round
    var currentPair: (Player, Player)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (tSystem != nil) {
            
            tSystem!.currentActiveWords = [] // Wipe the last played words

            // Show info about the round
            self.navigationItem.title = "Round \(tSystem!.playedRoundsNumber + 1)"
            wordsLeftLabel.text = "Words left: \(tSystem!.wordsLeft())"
            
            // Generate new pair
            currentPair = tSystem!.getNextPair()
            playerALabel.text = currentPair!.0.getName()
            playerBLabel.text = currentPair!.1.getName()
            
            // If previous results exist, show them
            if let prevResult = tSystem!.getPreviousResult() {
                previousPairResultLabel.text = "Previous result: \(prevResult)"
                tSystem!.clean()
            } else {
                previousPairResultLabel.text = "There is no previous results"
            }
        }
        
    }
    
    // MARK: Settings Changed
    
    /**
        Updates info about players (from round settings' delegate).
        
        :param: controller CurrentRoundSettingsTableViewController object
        :param: firstName String first player's name
        :param: secondName String second player's name
    */
    func roundSettingsDidChanged(controller: CurrentRoundSettingsTableViewController, firstName: String, secondName: String) {
        currentPair!.0.setName(firstName)
        currentPair!.1.setName(secondName)
        
        playerALabel.text = currentPair!.0.getName()
        playerBLabel.text = currentPair!.1.getName()
    }

    /**
        Action for the start game button.
    */
    @IBAction func playButtonAction(sender: UIButton) {
    }
    
    /**
        Action for the settings button.
    */
    @IBAction func settingsButtonAction(sender: UIBarButtonItem) {
    }
    
    // MARK: - Segue
    
    /**
        Prepares for segues.
        
        :param: segue UIStoryboardSegue object
        :param: sender AnyObject!
    */
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
