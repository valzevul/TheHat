//
//  GameResultsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the controller of game results
class GameResultsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    /// Tournament System object
    var tSystem: TournamentSystem?
    var results = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        results = tSystem!.getOverallResults()
    }
    
    /**
        Pops to the root view controller if the game was finished.
    
        :param: sender UIBarButton
    */
    @IBAction func didEndGameAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /**
        Returns number of player in the game.
    
        :param: section Index of a section
        :param: tableView Game Results table
        :returns: Int number of players
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tSystem!.gameObject.players.count
    }
    
    /**
        Creates new cell with player's results.
    
        :param: tableView Game Results table
        :param: indexPath cell's index
        :returns: GameResultTableViewCell object with player's results
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /// Cell with results
        let cell: GameResultsTableViewCell = tableView.dequeueReusableCellWithIdentifier("GameResultsCell") as! GameResultsTableViewCell
        
        /// Player object from Tournament System
        let player: Player = results[indexPath.row]
        
        cell.playerNameLabel?.text = "\(player.getName()!)"
        cell.playerScoreLabel?.text = "\(player.getOverallScore())"
        cell.teamIdLabel?.text = "\(player.teamId)"
        
        return cell

    }
}
