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
                ActiveWord(owner: Player(name: "D"), text: "lol4", status: "F")] // For dev purposes only!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.cells.append(ActiveWord(word: currentWord!, status: "OK"))
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
        cell.wordLabel?.text = self.cells[indexPath.row].getText()
        cell.wordResultImage = UIImageView(image: UIImage(named: self.cells[indexPath.row].getStatus()))
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as GameResultsViewController;
            gameResultsVC.gameObject = gameObject
        }
    }

}
