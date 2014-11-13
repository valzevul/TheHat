//
//  AddressBookTableViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 13/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class AddressBookTableViewController: UITableViewController {

    var addressBook: ABAddressBookRef?
    var contactList: NSArray?
    
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    func getContactNames() {
        var errorRef: Unmanaged<CFError>?
        addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        contactList = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        println("records in the array \(contactList!.count)")
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
            println("requesting access...")
            var errorRef: Unmanaged<CFError>? = nil
            addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    self.getContactNames()
                }
                else {
                    println("error")
                }
            })
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied || ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
            println("access denied")
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            println("access granted")
            self.getContactNames()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (contactList != nil) {
            return contactList!.count
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AddressBookTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddressBookCell", forIndexPath: indexPath) as AddressBookTableViewCell
        if (contactList != nil) {
            
            let record: ABRecordRef = contactList!.objectAtIndex(indexPath.row)
            let playerName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
            
            cell.playerNameLabel.text = "\(playerName)"
        } else {
            cell.playerNameLabel.text = "access denied"
        }
        
        return cell
    }


}
