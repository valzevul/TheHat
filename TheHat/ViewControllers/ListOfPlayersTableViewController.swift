//
//  ListOfPlayersTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class ListOfPlayersTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, PersonFromAddressBookDelegate {

    var tSystem: TournamentSystem?
    var lSettings: LocalSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Add new player
    
    
    // TODO: IMPLEMENT http://makeapppie.com/tag/addsubview-in-swift/
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let frameSize = tableView.frame
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frameSize.width, height: 50))
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, frameSize.width, 50)
        button.setTitle("+", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(40))
        button.addTarget(self, action: "addPlayerAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button)
        
        let buttonAddressBook = UIButton.buttonWithType(UIButtonType.System) as UIButton
        buttonAddressBook.frame = CGRectMake(0, 50, frameSize.width, 50)
        buttonAddressBook.setTitle("From Address Book", forState: UIControlState.Normal)
        buttonAddressBook.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(16))
        buttonAddressBook.addTarget(self, action: "addPlayerFromAddressBookAction:", forControlEvents: UIControlEvents.TouchUpInside)

        view.addSubview(buttonAddressBook)
        
        return view
    }
    
    func addPlayerFromAddressBookAction(sender: UIButton!) {
        self.performSegueWithIdentifier("selectFromAddressBook", sender: nil)
    }
    
    func personFromAddressBookDidSelected(controller: AddressBookTableViewController, name: String, image: UIImage) {
        let newPlayerId = self.tSystem!.gameObject.players.count + 1
        let numberOfWords = self.tSystem!.gameObject.numberOfWords!
        let newPlayer: Player = Player(name: name, image: image)
        self.tSystem!.gameObject.addPlayer(newPlayer)
        
        self.tableView.reloadData()
    }
    
    func addPlayerAction(sender: UIButton!)
    {
        let newPlayerId = self.tSystem!.gameObject.players.count + 1
        let numberOfWords = self.tSystem!.gameObject.numberOfWords!
        let newPlayer = self.tSystem!.gameObject.getNewPlayer(newPlayerId, numberOfWords: numberOfWords)
        self.tSystem!.gameObject.addPlayer(newPlayer)
        
        self.tableView.reloadData()
    }
    
    // MARK: - Create new cell with existing player
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tSystem!.gameObject.players.count
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
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
        
        
        return true
    }
    
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
