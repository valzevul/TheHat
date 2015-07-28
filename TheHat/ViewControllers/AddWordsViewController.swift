//
//  AddWordsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for addition new words or checking previous.
class AddWordsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate {
    
    /// Table view with words
    @IBOutlet weak var tableView: UITableView!
    
    /// Current player's id
    var playerIdx: Int?
    
    /// Tournament system object
    var tSystem: TournamentSystem?
    
    /// List of words of the player
    var words = [GameWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Fetch player's words
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
        let cell: WordTableViewCell = tableView.dequeueReusableCellWithIdentifier("WordCell") as! WordTableViewCell
        cell.wordsLabel.text = words[indexPath.row].text
        
        cell.complexityLabel.text = words[indexPath.row].getComplexity()
        
        cell.delegate = self
        cell.tag = indexPath.row + 1 // NEVER use the tag 0 'cause it's default value
        
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
    
    /**
        Provides an alertControll to edit a word.
    
        :param: cell MGSwipeTableCell
    */
    func editWord(cell: MGSwipeTableCell) {
        let alertController = UIAlertController(title: "Change word", message: "Edit this word:", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = self.words[cell.tag - 1].text
        }
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let c = (cell as! WordTableViewCell)
            let text = (alertController.textFields![0] as! UITextField).text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

            if (!text.isEmpty) {
                c.wordsLabel.text = text
                if (count(c.wordsLabel.text!) > 0) {
                    self.tSystem?.gameObject.changeWord(self.words[cell.tag - 1], newText: c.wordsLabel.text!)
                }
            }
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true) {
        }
        
        self.tableView.reloadData()
    }
    
    /**
        Remove a word from the game and updates the table.
    
        :param: tag Int index of the word to delete.
    */
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
    
    /**
        Shows button for addition new words.
    
        :param: tableView UITableView
        :param: section Int
    
        :returns: UIView?
    */
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let frameSize = tableView.frame
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frameSize.width, height: 50))
        
        // Button to create a new player
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(0, 0, frameSize.width, 50)
        button.setTitle("+", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(40))
        button.addTarget(self, action: "addWordAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        return view
    }
    
    /**
        Creates new word.
    
        :param: sender UIButton!
    */
    func addWordAction(sender: UIButton!) {
        let newWord = self.tSystem!.gameObject.getRandomWord(self.tSystem!.gameObject.players[playerIdx!])
        let gameWord = GameWord(owner: self.tSystem!.gameObject.players[playerIdx!], word: newWord)
        
        self.tSystem!.gameObject.players[playerIdx!].addWord(newWord)
        tSystem!.gameObject.words.append(gameWord)
        
        words = tSystem!.gameObject.wordsForPlayer(playerIdx!)
        self.tableView.reloadData()
    }
    
    /**
        Represents height of footer section.
    
        :param: tableView UITableView
        :param: section Int
    
        :returns: CGFloat height of footer.
    */
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
}
