//
//  RoundResultsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for round results
class RoundResultsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {

    /// Exit to the final results
    @IBOutlet weak var finishGameButton: UIBarButtonItem!
    
    /// Local Settings object
    var lSettings: LocalSettings?
    
    /// Tournament System object
    var tSystem: TournamentSystem?
    
    /// Last played word
    var currentWord: GameWord?
    
    /// List of all words from the round
    var cells = [GameWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.cells = tSystem!.currentGameWords
    }
    
    // MARK: - New cell with word
    
    /**
        Returns number of rows.
        
        :param: tableView UITableView with round results
        :param: section Int section
        :returns: Int number of rows
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    /**
        Creates new cell with a word.
        
        :param: tableView UITableView with round results
        :param: indexPath NSIndexPath for the new cell
        :returns: CustomTableViewCell object with a word
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomTableViewCell
        let word = self.cells[indexPath.row]
        cell.tag = indexPath.row
        
        switch (word.status.status) {
            case .Guessed:
                cell.wordResultImage.backgroundColor = Constants.OKColor
                cell.wordResultLabel.text = Constants.OK
            case .Failed:
                cell.wordResultImage.backgroundColor = Constants.FColor
                cell.wordResultLabel.text = Constants.F
            default:
                cell.wordResultImage.backgroundColor = Constants.MColor
                cell.wordResultLabel.text = Constants.M
        }
        
        cell.delegate = self
        
        cell.wordLabel?.text = word.text
        cell.leftSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.leftButtons = [
            MGSwipeButton(title: Constants.OK, backgroundColor: Constants.OKColor),
            MGSwipeButton(title: Constants.F, backgroundColor: Constants.FColor),
            MGSwipeButton(title: Constants.M, backgroundColor: Constants.MColor)]
        return cell
    }
    
    // MARK: - Swipe for cell
    
    /**
        Processes swipe of a cell with a word.
        
        :param: cell MGSwipeTableCell object which was swiped
        :param: index Int index of the cell
        :param: direction MGSwipeDirection object with a direction of the swipe
        :param: fromExpansion Bool flag process the expansion swipe
        
        :returns: Bool true if the cell closes after tap else false
    */
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        var status: String
        let word = self.cells[cell.tag]
        
        switch (index) {
        case 0:
            (cell as! CustomTableViewCell).wordResultImage.backgroundColor = Constants.OKColor
            (cell as! CustomTableViewCell).wordResultLabel.text = Constants.OK
        case 1:
            (cell as! CustomTableViewCell).wordResultImage.backgroundColor = Constants.FColor
            (cell as! CustomTableViewCell).wordResultLabel.text = Constants.F
        case 2:
            (cell as! CustomTableViewCell).wordResultImage.backgroundColor = Constants.MColor
            (cell as! CustomTableViewCell).wordResultLabel.text = Constants.M
        default:
            println("x")
        }
        
        tSystem?.changeWordsStatus(word, status: (cell as! CustomTableViewCell).wordResultLabel.text)
        
        return true
    }
    
    // MARK: - Segue
    
    /**
        Performs a segue with a new round or final results.
        
        :param: sender UIBarButtonItem object
    */
    @IBAction func nextRoundButtonAction(sender: UIBarButtonItem) {
        if (tSystem!.wordsLeft() < 1) {
            performSegueWithIdentifier("showGameResults", sender: nil)
        } else {
            performSegueWithIdentifier("nextRoundSegue", sender: nil)
        }
    }
    
    /**
        Prepares for a segue and passes all vital objects to the next screen.
        
        :param: segue UIStoryboardSegue
        :param: sender AnyObject!
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as! GameResultsViewController;
            gameResultsVC.tSystem = tSystem
        } else if (segue.identifier == "nextRoundSegue") {
            var nextRound = segue.destinationViewController as! StartGameViewController;
            nextRound.tSystem = tSystem
            nextRound.lSettings = lSettings
        }
    }

}
