//
//  StartScreenViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var multiplayerGameButton: UIButton!
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    @IBOutlet weak var infoBarButton: UIBarButtonItem!

    var mask: CALayer! // Animation mask
    var firstRun = true // Flag for animation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
    
        if (firstRun) { // Shows animated hat screen
            createLayerMask()
            setKeyFrameAnimation()
            firstRun = false
        }
        
        
        
        showTutorial()
    }
    
    func showTutorial() {
        performSegueWithIdentifier("showTutorial", sender: nil)
        
    }
    
    // MARK: - Animation of the hat
    
    func createLayerMask() {
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "thehat").CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        self.view.layer.mask = mask
    }
    
    func setKeyFrameAnimation() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.duration = 1
        keyFrameAnimation.delegate = self
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        setBounds(keyFrameAnimation)
    }
    
    func setBounds(keyFrameAnimation: CAKeyframeAnimation) {
        let initalBounds = NSValue(CGRect: mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
    }

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.view.layer.mask = nil // Remove mask when animation completes
    }

    
    @IBAction func newGameAction(sender: UIButton) {
    }
    @IBAction func multiplayerGameAction(sender: UIButton) {
    }
    @IBAction func infoBarButtonAction(sender: UIBarButtonItem) {
    }
    @IBAction func settingsBarButtonAction(sender: UIBarButtonItem) {
    }

}

