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
    var currentState = 5
    var amount = 10
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    
    var timer = NSTimer()
    var counter = 0
    var timeLeft = 0
    
    var gameTime: Int?
    
    var currentWord: Word?
    
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

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view).x
        amount -= 1
        
        
        // TODO: create normal change of state
        if (currentPoint < 0) {
            currentState -= 1
        } else {
            currentState += 1
        }
        
        if (amount == 0) {
            amount = 10
            if (currentState < 0) {
                wordFailed()
            } else {
                wordGuessed()
            }
            
            currentState = 5
        }
    }

    func wordGuessed() {
        println("Guessed")
        tSystem!.wordGuessed()
        currentWord = tSystem!.getNewWord()
        wordLabel.text = currentWord!.getText()
    }
    
    func wordFailed() {
        println("Failed")
        tSystem!.wordFailed()
    }
    
    func startTimer() {
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() -> Void {
        timeLeft = gameTime! - ++counter
        timerLabel.text = String(timeLeft)
        
        if (counter == gameTime!) {
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
