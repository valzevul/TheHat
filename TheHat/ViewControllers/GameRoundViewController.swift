//
//  GameRoundViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import SpriteKit

class GameRoundViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    // Create singletone for this one to aboid crashes
    var timer: NSTimer?
    
    var counter = 0
    var timeLeft = 0
    var gameTime: Int?
    var additionalTime: Int?
    
    var currentWord: ActiveWord?
    
    override func viewDidAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "\(tSystem!.currentPair!.0.getName()!) → \(tSystem!.currentPair!.1.getName()!)"
        
        if let gTime = namePreference.stringForKey("gameTime") {
            gameTime = gTime.toInt()
            timerLabel.text = "\(gameTime!)"
        }
        if let aTime = namePreference.stringForKey("additionalTime") {
            additionalTime = aTime.toInt()
        }
        
        currentWord = tSystem!.getNewWord()
        if (currentWord == nil) {
            performSegueWithIdentifier("timerFinished", sender: nil)
        }
        wordLabel.text = currentWord?.getText()
       
    }
    
    // MARK: - Animation
    
    // TODO: Implement: https://github.com/cwRichardKim/TinderSimpleSwipeCards

    func drawCircle(type: String) {
        var circleWidth = CGFloat(100)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRectMake(self.view.frame.width / 2 - 50, self.view.frame.height / 2 + 100, circleWidth, circleHeight))
        
        view.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(0.3, type: type)
    }
    
    
    // MARK: - Swipe Processing
    
    @IBAction func didLeftSwipe(sender: UISwipeGestureRecognizer) {
        wordFailed()
    }
    
    func wordFailed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        tSystem!.wordFailed(currentWord!)
        
        // TODO: Change segue to "wordFailed" & Fix redundant segue for failed word
        performSegueWithIdentifier("timerFinished", sender: self)
    }
    
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        drawCircle("green")
        wordGuessed()
    }

    func wordGuessed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        tSystem!.wordGuessed(currentWord!)
        currentWord = tSystem!.getNewWord()
        if (currentWord == nil) {
            performSegueWithIdentifier("timerFinished", sender: nil)
        } else {
            wordLabel.text = currentWord!.getText()
        }
        
    }
    
    // MARK: - Timer
    
    func update() -> Void {
        timeLeft = gameTime! - ++counter
        timerLabel.text = String(timeLeft)
        
        if (timeLeft < 1) {
            UIView.animateWithDuration(1.0, animations: {
                self.timerLabel.textColor = UIColor.redColor()
            })
        }
        
        if (timeLeft == (additionalTime! * (-1) - 1)) {
            if (currentWord != nil) {
                currentWord!.incAttemptsNumber()
                currentWord?.incTime(counter)
            
                tSystem!.wordMissed(currentWord!)
            }
            if (timer != nil ) {
                timer!.invalidate()
                performSegueWithIdentifier("timerFinished", sender: self)
            }
        }
        
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timerFinished") {
            if (timer != nil ) {
                timer!.invalidate()
                timer = nil
            }
            tSystem?.playedRoundsNumber += 1
            var roundResultsVC = segue.destinationViewController as RoundResultsTableViewController;
            roundResultsVC.gameObject = gameObject
            roundResultsVC.tSystem = tSystem
            roundResultsVC.lSettings = lSettings
            roundResultsVC.currentWord = currentWord
        }
    }

}
