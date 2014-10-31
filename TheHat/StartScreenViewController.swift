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

    var mask: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "thehat").CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        self.view.layer.mask = mask
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.duration = 1
        keyFrameAnimation.delegate = self
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initalBounds = NSValue(CGRect: mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.view.layer.mask = nil //remove mask when animation completes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

