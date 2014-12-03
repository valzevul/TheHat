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
    
    /// Tournament system object
    var tSystem: TournamentSystem?
    
    var words = [ActiveWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        words = tSystem!.gameObject.wordsForPlayer(playerIdx!)
        
    }
    
    /**
    Returns number of rows.
    
    :param: tableView UITableView
    :param: section Int
    
    :return: Int number of words
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    /**
    Returns new cell object.
    
    :param: tableView UITableView
    :param: indexPath NSIndexPath
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WordTableViewCell = tableView.dequeueReusableCellWithIdentifier("WordCell") as WordTableViewCell
        cell.wordsLabel.text = words[indexPath.row].getText()
        
        cell.delegate = self
        cell.tag = indexPath.row + 1 // NEVER use the tag 0
        
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
            editWord(cell)
            break
        case 1: // delete
            removeWord(cell.tag)
            break
        default:
            break
        }
        return true
    }
    
    func editWord(cell: MGSwipeTableCell) {
        let alertController = UIAlertController(title: "Change word", message: "Edit this word:", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = self.words[cell.tag - 1].getText()
        }
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let c = (cell as WordTableViewCell)
            c.wordsLabel.text = (alertController.textFields![0] as UITextField).text
            
            self.tSystem?.gameObject.changeWord(self.words[cell.tag - 1], text: c.wordsLabel.text)
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true) {
        }

        
        
        self.tableView.reloadData()
    }
    
    func removeWord(tag: Int) {
        
        let word = words[tag - 1]
        
        tSystem?.gameObject.removeWord(word)
        words = tSystem!.gameObject.wordsForPlayer(playerIdx!)
        
        // Remove from table
        self.tableView.reloadData()
    }
    
    /**
    Confirm changes in player's words.
    
    :param: sender UIBarButton
    */
    @IBAction func wordsAddedAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
