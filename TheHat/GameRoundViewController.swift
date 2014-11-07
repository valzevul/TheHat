//
//  GameRoundViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class GameRoundViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    let timer = NSTimer()
    var counter = 0
    var timeLeft = 0
    var gameTime: Int?
    var additionalTime: Int?
    
    var currentWord: ActiveWord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "\(tSystem!.currentPair!.0.name!) → \(tSystem!.currentPair!.1.name!)"
        
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTime = gTime.toInt()
            timerLabel.text = "\(gameTime!)"
        }
        if let aTime = namePreference.stringForKey("additionalTime") {
            additionalTime = aTime.toInt()
        }
        
        startTimer()
        currentWord = tSystem!.getNewWord()
        wordLabel.text = currentWord?.getText()
    }
    
    // MARK: - Swipe Processing
    
    @IBAction func didLeftSwipe(sender: UISwipeGestureRecognizer) {
        wordFailed()
    }
    
    func wordFailed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        timer.invalidate()
        tSystem!.wordFailed(currentWord!)
        
        // TODO: Change segue to "wordFailed" & Fix redundant segue for failed word
        performSegueWithIdentifier("timerFinished", sender: self)
    }
    
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        wordGuessed()
    }

    func wordGuessed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        tSystem!.wordGuessed(currentWord!)
        currentWord = tSystem!.getNewWord()
        wordLabel.text = currentWord!.getText()
    }
    
    // MARK: - Timer
    
    func startTimer() {
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() -> Void {
        timeLeft = gameTime! - ++counter
        timerLabel.text = String(timeLeft)
        
        if (timeLeft < 1) {
            UIView.animateWithDuration(1.0, animations: {
                self.timerLabel.textColor = UIColor.redColor()
            })
        }
        
        if (timeLeft == (additionalTime! * (-1) - 1)) {
            
            currentWord!.incAttemptsNumber()
            currentWord?.incTime(counter)
            
            tSystem!.wordMissed(currentWord!)
            timer.invalidate()
            performSegueWithIdentifier("timerFinished", sender: self)
        }
        
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timerFinished") {
            tSystem?.playedRoundsNumber += 1
            var roundResultsVC = segue.destinationViewController as RoundResultsTableViewController;
            roundResultsVC.gameObject = gameObject
            roundResultsVC.tSystem = tSystem
            roundResultsVC.lSettings = lSettings
            roundResultsVC.currentWord = currentWord
        }
    }

}
