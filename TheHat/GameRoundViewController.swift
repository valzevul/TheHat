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
    
    var timer = NSTimer()
    var counter = 0
    var timeLeft = 0
    
    var gameTime: Int?
    var additionalTime: Int?
    var currentWord: ActiveWord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "\(tSystem!.currentPair!.0.name!) → \(tSystem!.currentPair!.1.name!)"
        
        var namePreference = NSUserDefaults.standardUserDefaults()
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTime = gTime.toInt()
        }
        
        if let aTime = namePreference.stringForKey("additionalTime") {
            additionalTime = aTime.toInt()
        }
        
        
        timerLabel.text = "\(gameTime!)"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        startTimer()
        currentWord = tSystem!.getNewWord()
        wordLabel.text = currentWord?.getText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        startTimer()
    }
    
    
    @IBAction func didLeftSwipe(sender: UISwipeGestureRecognizer) {
        wordFailed()
    }
    
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        wordGuessed()
    }

    func wordGuessed() {
        println("Guessed")
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        
        tSystem!.wordGuessed(currentWord!)
        currentWord = tSystem!.getNewWord()
        wordLabel.text = currentWord!.getText()
    }
    
    func wordFailed() {
        println("Failed")
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        timer.invalidate()
        tSystem!.wordFailed(currentWord!)
        performSegueWithIdentifier("timerFinished", sender: self) // TODO: Change segue to "wordFailed" & Fix redundant segue for failed word
    }
    
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
