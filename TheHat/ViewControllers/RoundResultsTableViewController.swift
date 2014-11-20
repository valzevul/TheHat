//
//  RoundResultsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class RoundResultsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {

    @IBOutlet weak var finishGameButton: UIBarButtonItem!
    
    var lSettings: LocalSettings?
    var tSystem: TournamentSystem?
    var currentWord: Word?
    var cells = [ActiveWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.cells = tSystem!.currentActiveWords

    }
    
    // MARK: - New cell with word
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as CustomTableViewCell
        let word = self.cells[indexPath.row]
        cell.tag = indexPath.row
        
        switch (word.getStatus()) {
            case "OK":
                cell.wordResultImage.backgroundColor = Constants.OKColor
                cell.wordResultLabel.text = "OK"
            case "F":
                cell.wordResultImage.backgroundColor = Constants.FColor
                cell.wordResultLabel.text = "F"
            default:
                cell.wordResultImage.backgroundColor = Constants.MColor
                cell.wordResultLabel.text = "?"
        }
        
        cell.delegate = self
        
        cell.wordLabel?.text = word.getText()
        cell.leftSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.leftButtons = [
            MGSwipeButton(title: "OK", backgroundColor: Constants.OKColor),
            MGSwipeButton(title: "F", backgroundColor: Constants.FColor),
            MGSwipeButton(title: "?", backgroundColor: Constants.MColor)]
        return cell
    }
    
    // MARK: - Swipe for cell
    
    // TODO: Update word in activeWords array!
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch (index) {
        case 0:
            self.cells[cell.tag].changeStatus("OK")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = Constants.OKColor
            (cell as CustomTableViewCell).wordResultLabel.text = "OK"
        case 1:
            self.cells[cell.tag].changeStatus("Failed")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = Constants.FColor
            (cell as CustomTableViewCell).wordResultLabel.text = "F"
        case 2:
            self.cells[cell.tag].changeStatus("?")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = Constants.MColor
            (cell as CustomTableViewCell).wordResultLabel.text = "?"
        default:
            println("x")
        }
        return true
    }
    
    // MARK: - Segue
    
    @IBAction func nextRoundButtonAction(sender: UIBarButtonItem) {
        if (tSystem!.wordsLeft() < 1) {
            performSegueWithIdentifier("showGameResults", sender: nil)
        } else {
            performSegueWithIdentifier("nextRoundSegue", sender: nil)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as GameResultsViewController;
            gameResultsVC.tSystem = tSystem
        } else if (segue.identifier == "nextRoundSegue") {
            var nextRound = segue.destinationViewController as StartGameViewController;
            nextRound.tSystem = tSystem
            nextRound.lSettings = lSettings
        }
    }

}
