//
//  AddWordsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class AddWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerIdx: Int?
    var player: Player?
    var tSystem: TournamentSystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        player = tSystem!.gameObject.players[playerIdx!]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player!.getNumberOfWords()
    }
    
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
    
    @IBAction func wordsAddedAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
