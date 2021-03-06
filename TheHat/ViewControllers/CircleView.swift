//
//  CircleView.swift
//  TheHat
//
//  Created by Vadim Drobinin on 9/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class draws a circle at the view which shows a status of a word
class CircleView: UIView {

    /// Animation layer
    var circleLayer: CAShapeLayer!
    
    func setUp() {
        self.backgroundColor = UIColor.clearColor()
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.lineWidth = 5.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    /**
        Creates new class object from a frame.
        
        :param: frame CGRect frame of the circle
    
        :returns: CircleView object
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    /**
        Creates new class object.
        
        :param: aDecoder NSDecoder
        
        :returns: CircleView object
    */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    /**
        Draws a circle with animation and fills it with a color.
        
        :param: duration NSInterval duration of the animation
        :param: type String type of a circle (green, red, etc)
    */
    func animateCircle(duration: NSTimeInterval, type: String) {
        
        if (type == "green") {
            circleLayer.strokeColor = Constants.OKColor.CGColor
        } else if (type == "red") {
            circleLayer.strokeColor = Constants.FColor.CGColor
        }
        
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.delegate = self
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
    /**
        Removes circle from the view after animation's end
        
        :param: anim CAAnimation object
        :flag: Bool true if animation finished else false
    */
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        // Hides animation
        circleLayer.removeAllAnimations()
        self.hidden = true
    }
    

}
