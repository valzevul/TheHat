//
//  GameResultsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class GameResultsViewController: UIViewController {

    var gameObject: Game?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func endGameButtonAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
