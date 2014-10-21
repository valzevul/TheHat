//
//  GameRoundViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class GameRoundViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    var currentState = 5
    var amount = 10
    
    var timer = NSTimer()
    var counter = 0
    var timeLeft = 0
    
    let max_time = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        // Do any additional setup after loading the view.
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
    }
    
    func wordFailed() {
        println("Failed")
    }
    
    func startTimer() {
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() -> Void {
        timeLeft = max_time - ++counter
        timerLabel.text = String(timeLeft)
        
        if (counter == max_time) {
            timer.invalidate()
            performSegueWithIdentifier("timerFinished", sender: self)
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
