//
//  RoundResultsTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 26/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class RoundResultsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var finishGameButton: UIBarButtonItem!
    
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var currentWord: Word?
    var cells = [ActiveWord(owner: Player(name: "A"), text: "lol", status: "OK"),
                ActiveWord(owner: Player(name: "B"), text: "lol2", status: "OK"),
                ActiveWord(owner: Player(name: "C"), text: "lol3", status: "OK"),
                ActiveWord(owner: Player(name: "D"), text: "lol4", status: "Failed")] // For dev purposes only!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.cells.append(ActiveWord(word: currentWord!, status: "?"))
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TODO:
    // Implement this one:
    // http://www.appcoda.com/swipeable-uitableviewcell-tutorial/
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.row) {
        case 1:
            println("guessed")
            tSystem!.wordGuessed()
        case 2:
            println("failed")
            tSystem!.wordFailed()
        case 3:
            println("missed")
            tSystem!.wordMissed(currentWord!)
        default:
            println("other row")
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as CustomTableViewCell
        let word = self.cells[indexPath.row]
        let image = UIImage(named: word.getStatus());
        
        cell.wordLabel?.text = word.getText()
        cell.wordResultImage.image = image
        cell.leftSwipeSettings.transition = MGSwipeTransition.Transition3D
        cell.leftButtons = [
                            MGSwipeButton(title: "OK", backgroundColor: UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.7)),
                            MGSwipeButton(title: "F", backgroundColor: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.7)),
                            MGSwipeButton(title: "?", backgroundColor: UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.7))
                            ]
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as GameResultsViewController;
            gameResultsVC.gameObject = gameObject
        }
    }

}
