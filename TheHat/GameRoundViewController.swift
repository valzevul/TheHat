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
    var currentWord: ActiveWord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var namePreference = NSUserDefaults.standardUserDefaults()
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTime = gTime.toInt()
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
        
        UIView.animateWithDuration(NSTimeInterval(1.0), animations: { () -> Void in
            self.wordLabel.textColor = UIColor.greenColor()
        }) { (Bool) -> Void in
            self.wordLabel.textColor = UIColor.blackColor()
            return
        }
    }
    
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(NSTimeInterval(1.0), animations: { () -> Void in
            self.wordLabel.textColor = UIColor.greenColor()
            }) { (Bool) -> Void in
                self.wordLabel.textColor = UIColor.blackColor()
                return
        }
        
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
        
        if (timeLeft == 0) {
            
            currentWord!.incAttemptsNumber()
            currentWord?.incTime(counter)
            
            tSystem!.wordMissed(currentWord!)
            timer.invalidate()
            performSegueWithIdentifier("timerFinished", sender: self)
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timerFinished") {
            var roundResultsVC = segue.destinationViewController as RoundResultsTableViewController;
            roundResultsVC.gameObject = gameObject
            roundResultsVC.tSystem = tSystem
            roundResultsVC.lSettings = lSettings
            roundResultsVC.currentWord = currentWord
        }
    }

}
