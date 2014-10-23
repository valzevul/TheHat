//
//  StartGameViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var previousPairResultLabel: UILabel!
    @IBOutlet weak var wordsLeftLabel: UILabel!
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerBLabel: UILabel!
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var currentPair: (Player, Player)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (tSystem != nil) {
            
            currentPair = tSystem!.getNextPair()
            
            playerALabel.text = currentPair!.0.name
            playerBLabel.text = currentPair!.1.name
            
            if let prevResult = tSystem!.getPreviousResult() {
                previousPairResultLabel.text = "Previous result: \(prevResult)"
            }
            
            wordsLeftLabel.text = "Words left: \(tSystem!.wordsLeft())"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonAction(sender: UIButton) {
    }
    @IBAction func settingsButtonAction(sender: UIBarButtonItem) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "startNewRound") {
            var gameRoundVC = segue.destinationViewController as GameRoundViewController;
            gameRoundVC.gameObject = gameObject
            gameRoundVC.tSystem = tSystem
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
