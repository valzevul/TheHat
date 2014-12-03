//
//  AddWordsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for addition new words or checking previous.
class AddWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate {
    
    /// Table view with words
    @IBOutlet weak var tableView: UITableView!
    
    /// Current player's id
    var playerIdx: Int?
    
    /// Player's object
    var player: Player?
    
    /// Tournament system object
    var tSystem: TournamentSystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        player = tSystem!.gameObject.players[playerIdx!]
        
    }
    
    /**
    Returns number of rows.
    
    :param: tableView UITableView
    :param: section Int
    
    :return: Int number of words
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player!.getNumberOfWords()
    }
    
    /**
    Returns new cell object.
    
    :param: tableView UITableView
    :param: indexPath NSIndexPath
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WordTableViewCell = tableView.dequeueReusableCellWithIdentifier("WordCell") as WordTableViewCell
        cell.wordsLabel.text = player!.getWords()[indexPath.row].getText()
        
        cell.delegate = self
        
        cell.rightSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.rightButtons = [
            MGSwipeButton(title: "Edit", backgroundColor: Constants.editColor),
            MGSwipeButton(title: "Delete", backgroundColor: Constants.deleteColor)]
    
        return cell
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
        case 0: // edit
            println("edit")
            break
        case 1: // delete
            println("delete")
            break
        default:
            break
        }
        return true
    }
    
    /**
    Confirm changes in player's words.
    
    :param: sender UIBarButton
    */
    @IBAction func wordsAddedAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
