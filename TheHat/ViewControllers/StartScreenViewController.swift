//
//  StartScreenViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the first screen
class StartScreenViewController: BaseViewController {

    /// Start New Game button
    @IBOutlet weak var newGameButton: UIButton!
    
    /// Settings button
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    
    /// Info button
    @IBOutlet weak var infoBarButton: UIBarButtonItem!

    /// Animation mask
    var mask: CALayer!
    
    /// Flag for animation (to avoid multiple runs)
    var firstRun = true // Flag for animation
    
    /// Global settings
    let namePreference = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstRun) { // Shows animated hat screen
            createLayerMask()
            setKeyFrameAnimation()
            firstRun = false
        }
        
        if let tutorial = namePreference.stringForKey("showTutorial") {
            if (tutorial == "1") {
                showTutorial()
            }
        } else {
            showTutorial()
            // TODO: add default settings about tutorial after the first show
        }
    }
    
    /**
        Performs segue for the tutorial.
    */
    func showTutorial() {
        performSegueWithIdentifier("showTutorial", sender: nil)
    }
    
    // MARK: - Animation of the hat
    
    /**
        Creates layer mask for the hat animation.
    */
    func createLayerMask() {
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "thehat").CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        self.view.layer.mask = mask
    }
    
    /**
        Sets keyframe for the hat animation.
    */
    func setKeyFrameAnimation() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.duration = 1
        keyFrameAnimation.delegate = self
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        setBounds(keyFrameAnimation)
    }
    
    /**
        Sets bound for the hat animation.
        
        :param: keyFrameAnimation CAKeyFrameAnimation object
    */
    func setBounds(keyFrameAnimation: CAKeyframeAnimation) {
        let initalBounds = NSValue(CGRect: mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
    }

    /**
        Disables mask with the hat.
        
        :param: anim CAANimation!
        :param: flag Bool
    */
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.view.layer.mask = nil // Remove mask when animation completes
    }

    
    /**
        Starts new game.
        
        :param: sender UIButton
    */
    @IBAction func newGameAction(sender: UIButton) {
    }
    
    /**
        Shows game info.
        
        :param: sender UIButton
    */
    @IBAction func infoBarButtonAction(sender: UIBarButtonItem) {
    }
    
    /**
        Shows settings.
        
        :param: sender UIButton
    */
    @IBAction func settingsBarButtonAction(sender: UIBarButtonItem) {
    }

}

