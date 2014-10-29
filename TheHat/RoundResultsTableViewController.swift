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
    
    var gameObject: Game?
    var lSettings: LocalSettings?
    var tSystem: TournamentSystem?
    var currentWord: Word?
    var cells = [ActiveWord(owner: Player(name: "A"), text: "lol", status: "OK"),
                ActiveWord(owner: Player(name: "B"), text: "lol2", status: "OK"),
                ActiveWord(owner: Player(name: "C"), text: "lol3", status: "OK"),
                ActiveWord(owner: Player(name: "D"), text: "lol4", status: "Failed")] // For dev purposes only!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cells.append(ActiveWord(word: currentWord!, status: "?"))
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
            let image = UIImage(named: "OK")
            (cell as CustomTableViewCell).wordResultImage.image = image
        case 1:
            self.cells[cell.tag].changeStatus("Failed")
            let image = UIImage(named: "Failed")
            (cell as CustomTableViewCell).wordResultImage.image = image
        case 2:
            self.cells[cell.tag].changeStatus("?")
            let image = UIImage(named: "?")
            (cell as CustomTableViewCell).wordResultImage.image = image
        default:
            println("x")
        }
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as CustomTableViewCell
        let word = self.cells[indexPath.row]
        cell.tag = indexPath.row
        let image = UIImage(named: word.getStatus())
        
        cell.delegate = self
        
        cell.wordLabel?.text = word.getText()
        cell.wordResultImage.image = image
        cell.leftSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.leftButtons = [
            MGSwipeButton(title: "OK", backgroundColor: UIColor(red: 0.07, green: 0.75, blue: 0.16, alpha: 0.7)),
            MGSwipeButton(title: "F", backgroundColor: UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 0.7)),
            MGSwipeButton(title: "?", backgroundColor: UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 0.7))]
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
