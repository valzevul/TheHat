//
//  StartGameViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var wordsLeftLabel: UILabel!
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerBLabel: UILabel!
    
    var game = Game.createRandomGame(10, numberOfWords: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(game.players)
        
        // Do any additional setup after loading the view.
        
        // TODO: Game() object
        // TODO: List of Player objects
        
        // TODO: Choose two random players
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonAction(sender: UIButton) {
    }
    @IBAction func settingsButtonAction(sender: UIBarButtonItem) {
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
