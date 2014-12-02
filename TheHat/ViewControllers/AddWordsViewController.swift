//
//  AddWordsViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 2/12/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class AddWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var playerIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    @IBAction func wordsAddedAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
