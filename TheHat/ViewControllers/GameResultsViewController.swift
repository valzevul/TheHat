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
    
    @IBAction func endGameButtonAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameObject!.players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomPlayerTableCell = tableView.dequeueReusableCellWithIdentifier("PlayerNameCell") as CustomPlayerTableCell
        let player: Player = self.gameObject!.players[indexPath.row] as Player
        
        cell.playerLabel?.text = "\(player.getName()): \(player.getOverallScore()))"
        
        return cell

    }
}
