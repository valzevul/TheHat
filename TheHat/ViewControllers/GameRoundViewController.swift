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
    var currentWord: GameWord?
    
    /// UIView for circle animation
    @IBOutlet weak var circleView: CircleView!
    
    /**
        Sets timer for current round.
        
        :param: animated Bool
    */
    override func viewDidAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        timeLeft = gameTime!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordLabel.adjustsFontSizeToFitWidth = true
        
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
        wordLabel.text = currentWord?.text
       
    }
    
    // MARK: - Animation
    
    // TODO: Implement: https://github.com/cwRichardKim/TinderSimpleSwipeCards

    /**
        Draws a circle at the view.
        
        :param: type String type of the circle (red, green, etc)
    */
    func drawCircle(type: String) {
        self.circleView.hidden = false
    
        // Animate the drawing of the circle over the course of 1 second
        self.circleView.animateCircle(0.3, type: type)
    }
    
    
    // MARK: - Swipe Processing
    
    /**
        Processes left swipe at the view.
        
        :param: sender UISwipeGestureRecognizer
    */
    @IBAction func didRightSwipe(sender: UISwipeGestureRecognizer) {
        drawCircle("red")
        wordFailed()
    }
    
    /**
        Indicates that a word was failed.
    */
    func wordFailed() {
        currentWord?.status.updateStatus(counter, isNewAttempt: true, status: currentWord!.status.status)
        tSystem!.wordFailed(currentWord!)
        
        // TODO: Change segue to "wordFailed" & Fix redundant segue for failed word
        performSegueWithIdentifier("timerFinished", sender: self)
    }
    
    /**
        Processes right swipe at the view.
        
        :param: sender UISwipeGestureRecognizer
    */
    @IBAction func didLeftSwipe(sender: UISwipeGestureRecognizer) {
        drawCircle("green")
        wordGuessed()
    }

    /**
        Indicates that a word was guessed.
    */
    func wordGuessed() {
        currentWord?.status.updateStatus(counter, isNewAttempt: true, status: currentWord!.status.status)
        tSystem!.wordGuessed(currentWord!)
        if (timeLeft > 1) {
            currentWord = tSystem!.getNewWord()
            if (currentWord == nil) {
                performSegueWithIdentifier("timerFinished", sender: nil)
            } else {
                wordLabel.text = currentWord!.text
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
                currentWord?.status.updateStatus(counter, isNewAttempt: true, status: currentWord!.status.status)
            
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
            var roundResultsVC = segue.destinationViewController as RoundResultsTableViewController;
            roundResultsVC.tSystem = tSystem
            roundResultsVC.lSettings = lSettings
            roundResultsVC.currentWord = currentWord
        }
    }

}
