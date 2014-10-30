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
    
    let OKColor = UIColor(red: 0.07, green: 0.75, blue: 0.16, alpha: 0.7)
    let FColor = UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 0.7)
    let MColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 0.7)
    
    var gameObject: Game?
    var lSettings: LocalSettings?
    var tSystem: TournamentSystem?
    var currentWord: Word?
    var cells = [ActiveWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cells = tSystem!.currentActiveWords // Know issue: failed words show twice
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch (index) {
        case 0:
            self.cells[cell.tag].changeStatus("OK")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = OKColor
            (cell as CustomTableViewCell).wordResultLabel.text = "OK"
        case 1:
            self.cells[cell.tag].changeStatus("Failed")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = FColor
            (cell as CustomTableViewCell).wordResultLabel.text = "F"
        case 2:
            self.cells[cell.tag].changeStatus("?")
            (cell as CustomTableViewCell).wordResultImage.backgroundColor = MColor
            (cell as CustomTableViewCell).wordResultLabel.text = "?"
        default:
            println("x")
        }
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as CustomTableViewCell
        let word = self.cells[indexPath.row]
        cell.tag = indexPath.row
        
        switch (word.getStatus()) {
            case "OK":
                cell.wordResultImage.backgroundColor = OKColor
                cell.wordResultLabel.text = "OK"
            case "F":
                cell.wordResultImage.backgroundColor = FColor
                cell.wordResultLabel.text = "F"
            default:
                cell.wordResultImage.backgroundColor = MColor
                cell.wordResultLabel.text = "?"
        }
        
        cell.delegate = self
        
        cell.wordLabel?.text = word.getText()
        cell.leftSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.leftButtons = [
            MGSwipeButton(title: "OK", backgroundColor: OKColor),
            MGSwipeButton(title: "F", backgroundColor: FColor),
            MGSwipeButton(title: "?", backgroundColor: MColor)]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as GameResultsViewController;
            gameResultsVC.gameObject = gameObject
        } else if (segue.identifier == "nextRoundSegue") {
            var nextRound = segue.destinationViewController as StartGameViewController;
            nextRound.gameObject = gameObject
            nextRound.tSystem = tSystem
            nextRound.lSettings = lSettings
        }
    }

}
