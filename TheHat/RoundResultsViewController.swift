//
//  RoundResultsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 21/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class RoundResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UIView!
    var gameObject: Game?
    var tSystem: TournamentSystem?
    var currentWord: Word?
    var cells = ["", "Guessed", "Failed", "Missed"]
    
    
    @IBOutlet weak var showResultsButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cells[0] = "Last word: \(currentWord!.getText())"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showResultsAction(sender: UIBarButtonItem) {
    }
    
    
    // TODO:
    // Implement this one:
    // http://www.appcoda.com/swipeable-uitableviewcell-tutorial/
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = self.cells[indexPath.row]
        
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showGameResults") {
            var gameResultsVC = segue.destinationViewController as GameResultsViewController;
            gameResultsVC.gameObject = gameObject
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
