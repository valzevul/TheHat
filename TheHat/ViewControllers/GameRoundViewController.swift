//
//  GameRoundViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import SpriteKit // To draw a circle at the view

/// Class for the current game round
class GameRoundViewController: BaseViewController {

    /// Word-to-guess label
    @IBOutlet weak var wordLabel: UILabel!
    
    /// Left time label
    @IBOutlet weak var timerLabel: UILabel!
    
    /// Tournament System object
    var tSystem: TournamentSystem?
    
    /// Local Settings object
    var lSettings: LocalSettings?
    
    /// Loaded global settings
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    /// Timer for the left time
    var timer: NSTimer?
    
    /// Time spent at the screen
    var counter = 0
    
    /// Time left
    var timeLeft = 0
    
    /// Game time variable
    var gameTime: Int?
    
    /// Additional time variable
    var additionalTime: Int?
    
    /// The last word at the screen
    var currentWord: ActiveWord?
    
    override func viewDidAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        timeLeft = gameTime!
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

    /**
    Draws a circle at the view.
    */
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
    
    /**
    Processes left swipe at the view.
    */
    @IBAction func didLeftSwipe(sender: UISwipeGestureRecognizer) {
        wordFailed()
    }
    
    /**
    Indicates that a word was failed.
    */
    func wordFailed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        tSystem!.wordFailed(currentWord!)
        
        // TODO: Change segue to "wordFailed" & Fix redundant segue for failed word
        performSegueWithIdentifier("timerFinished", sender: self)
    }
    
    /**
    Processes right swipe at the view.
    */
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        drawCircle("green")
        wordGuessed()
    }

    /**
    Indicates that a word was guessed.
    */
    func wordGuessed() {
        currentWord!.incAttemptsNumber()
        currentWord?.incTime(counter)
        
        tSystem!.wordGuessed(currentWord!)
        if (timeLeft > 1) {
            currentWord = tSystem!.getNewWord()
            if (currentWord == nil) {
                performSegueWithIdentifier("timerFinished", sender: nil)
            } else {
                wordLabel.text = currentWord!.getText()
            }
        } else {
            performSegueWithIdentifier("timerFinished", sender: nil)
        }
        
    }
    
    // MARK: - Timer
    
    /**
    Updates timer info.
    */
    func update() -> Void {
        timeLeft = gameTime! - ++counter
        timerLabel.text = String(timeLeft)
        
        if (timeLeft < 1) {
            UIView.animateWithDuration(1.0, animations: {
                self.timerLabel.textColor = UIColor.redColor()
            })
        }
        
        if (timeLeft == additionalTime! * (-1)) {
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

    /**
    Prepares for a segue.
    
    :param: UIStoryboardSegue object
    :param: sender AnyObject!
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timerFinished") {
            if (timer != nil ) {
                timer!.invalidate()
                timer = nil
            }
            tSystem?.playedRoundsNumber += 1
            var roundResultsVC = segue.destinationViewController as RoundResultsTableViewController;
            roundResultsVC.tSystem = tSystem
            roundResultsVC.lSettings = lSettings
            roundResultsVC.currentWord = currentWord
        }
    }

}
