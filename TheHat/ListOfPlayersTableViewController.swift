//
//  ListOfPlayersTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class ListOfPlayersTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {

    var gameObject: Game?
    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showStartRoundScreen") {
            var startGameVC = segue.destinationViewController as StartGameViewController
            startGameVC.gameObject = gameObject
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameObject!.players.count
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        let alertController = UIAlertController(title: "Change player's name", message: "Input new player's name:", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New name"
        }
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let c = (cell as CustomPlayerTableCell)
            c.playerLabel?.text = (alertController.textFields![0] as UITextField).text
            self.gameObject!.players[cell.tag].name = c.playerLabel?.text
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
        
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomPlayerTableCell = tableView.dequeueReusableCellWithIdentifier("PlayerNameCell") as CustomPlayerTableCell
        cell.tag = indexPath.row
        // let image = UIImage(named: word.getStatus())
        
        cell.delegate = self
        
        cell.playerLabel?.text = self.gameObject!.players[indexPath.row].name
        // cell.wordResultImage.image = image
        cell.rightSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.rightButtons = [
            MGSwipeButton(title: "+ words", backgroundColor: UIColor(red: 0.07, green: 0.75, blue: 0.16, alpha: 0.7)),
            MGSwipeButton(title: "Edit", backgroundColor: UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 0.7)),
            MGSwipeButton(title: "Delete", backgroundColor: UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 0.7))]
        return cell
    }


}
