//
//  GameResultsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class GameResultsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var gameObject: Game?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func didEndGameAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameObject!.players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: GameResultsTableViewCell = tableView.dequeueReusableCellWithIdentifier("GameResultsCell") as GameResultsTableViewCell
        let player: Player = self.gameObject!.players[indexPath.row] as Player
        
        cell.playerNameLabel?.text = "\(player.getName()!)"
        cell.playerScoreLabel?.text = "\(player.getOverallScore())"
        
        return cell

    }
}
