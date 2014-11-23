//
//  ListOfPlayersTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class with a list of players to add to the game
class ListOfPlayersTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, PersonFromAddressBookDelegate {
    
    /// Tournament System object
    var tSystem: TournamentSystem?
    
    /// Local Settings
    var lSettings: LocalSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Add new player
    
    // TODO: IMPLEMENT http://makeapppie.com/tag/addsubview-in-swift/
    /// Height of the footer section with "+" and "Add from AB" buttons
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    /**
    Returns buttons for the footer section.
    
    :param: tableView UITableView object with a list of players
    :param: section Int number of section for the footer
    :returns: View with buttons
    */
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let frameSize = tableView.frame
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frameSize.width, height: 50))
        
        // Button to create a new player
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, frameSize.width, 50)
        button.setTitle("+", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(40))
        button.addTarget(self, action: "addPlayerAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        // Button to add from address book
        let buttonAddressBook = UIButton.buttonWithType(UIButtonType.System) as UIButton
        buttonAddressBook.frame = CGRectMake(0, 50, frameSize.width, 50)
        buttonAddressBook.setTitle("From Address Book", forState: UIControlState.Normal)
        buttonAddressBook.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(16))
        buttonAddressBook.addTarget(self, action: "addPlayerFromAddressBookAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(buttonAddressBook)
        
        return view
    }
    
    /**
    Performs segue for import contacts from the address book
    
    :param: sender UIButton
    */
    func addPlayerFromAddressBookAction(sender: UIButton!) {
        self.performSegueWithIdentifier("selectFromAddressBook", sender: nil)
    }
    
    /**
    Delegate's implementation for import contacts from address book
    
    :param: controller AddressBookTableViewController
    :param: name Name of a person from AB
    :param: image Image of a person from AB if exists or default picture
    */
    func personFromAddressBookDidSelected(controller: AddressBookTableViewController, name: String, image: UIImage) {
        let newPlayerId = self.tSystem!.gameObject.players.count + 1
        let numberOfWords = self.tSystem!.gameObject.numberOfWords!
        let newPlayer: Player = Player(name: name, image: image)
        self.tSystem!.gameObject.addPlayer(newPlayer)
        
        self.tableView.reloadData()
    }
    
    /**
    Action for players generator.
    
    :param: sender UIButton
    */
    func addPlayerAction(sender: UIButton!)
    {
        let newPlayerId = self.tSystem!.gameObject.players.count + 1
        let numberOfWords = self.tSystem!.gameObject.numberOfWords!
        let newPlayer = self.tSystem!.gameObject.getNewPlayer(newPlayerId, numberOfWords: numberOfWords)
        self.tSystem!.gameObject.addPlayer(newPlayer)
        
        self.tableView.reloadData()
    }
    
    // MARK: - Create new cell with existing player
    
    /**
    Returns number of rows.
    
    :param: tableView UITableView with a list of players
    :param: section Int index of the section
    :returns: Int number of rows in the section
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tSystem!.gameObject.players.count
    }
    
    /**
    Alert controll to change the person's name.
    
    :param: cell MGSwipeTableCell
    */
    func changeName(cell: MGSwipeTableCell!) {
        let alertController = UIAlertController(title: "Change player's name", message: "Input new player's name:", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New name"
        }
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let c = (cell as CustomPlayerTableCell)
            c.playerLabel?.text = (alertController.textFields![0] as UITextField).text
            (self.tSystem!.gameObject.players[cell.tag] as Player).setName(c.playerLabel!.text!)
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true) {
        }

    }
    
    /**
    Action for the tapped button.
    
    :param: cell MGSwipeTableCell
    :param: index Int index of tapped button
    :param: direction MGSwipeDirection
    :param: fromExpansion Bool
    */
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch index {
        case 0: // Add words
            break
        case 1: // Change name (= edit)
            changeName(cell)
            break
        case 2: // Delete
            break
        default:
            break
        }
        return true
    }
    
    /**
    Creates new cell with player's info.
    
    :param: tableView UITableView
    :param: indexPath NSIndexPath
    :returns: CustomPlayerTableCell
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomPlayerTableCell = tableView.dequeueReusableCellWithIdentifier("PlayerNameCell") as CustomPlayerTableCell

        cell.tag = indexPath.row
        cell.delegate = self
        let player = self.tSystem!.gameObject.players[indexPath.row]
        cell.playerLabel?.text = player.getName()
        
        if let image = player.getImage() {
            cell.playerIconImage.image = image
        }
        
        
        cell.rightSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.rightButtons = [
            MGSwipeButton(title: "+ words", backgroundColor: Constants.addColor),
            MGSwipeButton(title: "Edit", backgroundColor: Constants.editColor),
            MGSwipeButton(title: "Delete", backgroundColor: Constants.deleteColor)]
        
        return cell
    }
    
    // MARK: - Segue
    /**
    Pass vital objects to the next screen.
    
    :param: segue UIStoryboardSegue
    :param: sender AnyObject!
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showStartRoundScreen") {
            var startGameVC = segue.destinationViewController as StartGameViewController
            startGameVC.tSystem = tSystem
            startGameVC.lSettings = lSettings
        } else if (segue.identifier == "selectFromAddressBook") {
            var ab = segue.destinationViewController as AddressBookTableViewController
            ab.delegate = self
        }
    }
}
