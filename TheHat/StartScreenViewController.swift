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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

