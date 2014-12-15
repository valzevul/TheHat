//
//  InfoViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the info view
class InfoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showTutorialAction(sender: AnyObject) {
        performSegueWithIdentifier("showTutorialScreen", sender: nil)
    }
    
}
