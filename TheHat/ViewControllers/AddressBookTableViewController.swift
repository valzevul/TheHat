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

/// Delegete for the addition of a person from the Address book
protocol PersonFromAddressBookDelegate {
    
    /**
    Signature for the function awaken if a person was selected.
    
    :param: controller Address Book screen
    :param: name Person's name
    :param: image Person's image (if exists)
    */
    func personFromAddressBookDidSelected(controller: AddressBookTableViewController, name: String, image: UIImage)
}

/// Class for the Address book table
class AddressBookTableViewController: UITableViewController {

    /// Address book reference
    var addressBook: ABAddressBookRef?
    
    /// Delegate for the addition of a new person
    var delegate:PersonFromAddressBookDelegate? = nil
    
    /// List of persons from address book
    var contactList: NSArray?
    
    /// List of selected persons
    var selectedPersons = [Int]()
    
    /// Button to add a list of persons to the dict
    @IBOutlet weak var addPlayersButton: UIBarButtonItem!
    
    /**
    Exctracts reference to the address book.
    
    :param: abRef unmanaged reference
    :returns: Address Book object (if exists)
    */
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    /**
    Parse all names from the address book and reloads the table.
    */
    func getContactNames() {
        /// Error object for the extract method
        var errorRef: Unmanaged<CFError>?
        
        // Get address book
        addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        // Parse to the contact list
        contactList = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        // Update view
        self.tableView.reloadData()
    }
    
    /**
    Main block
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If not managed yet
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
            var errorRef: Unmanaged<CFError>? = nil
            addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    self.getContactNames()
                }
                else {
                    println("Error")
                }
            })
        }
        // If access denied
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied || ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
            println("Access denied")
        }
        // If parsing was successful
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            self.getContactNames()
        }
    }

    // MARK: - Table view data source
    
    /**
    Method to invoke the delegate and send a new player to the list of players.
    
    :param: tableView Address Book view
    :param: indexPath Index path of the selected row
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate != nil) {
            
            var cell = tableView.cellForRowAtIndexPath(indexPath)
            
            if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                cell?.accessoryType = UITableViewCellAccessoryType.None
            } else {
                selectedPersons.append(indexPath.row)
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
    }
    
    /**
    Determines a list of contacts.
    
    :param: tableView Addres Book table
    :param: section Number of rows in section
    :returns: Int number of contacts in addres book or 1 if access restricted
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (contactList != nil) {
            return contactList!.count // If address book was parsed successfuly
        }
        return 1
    }
    
    /**
    Creates a new cell.
    
    :param: tableView Address book table
    :param: indexPath Index of a new cell
    :return: AddressBookTableViewCell with a new player of "access denied" message
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /// A new cell to be returned
        let cell: AddressBookTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddressBookCell", forIndexPath: indexPath) as AddressBookTableViewCell
        

        // If access granted
        if (contactList != nil) {
            
            /// Contact entry for the person
            let record: ABRecordRef = contactList!.objectAtIndex(indexPath.row)
            
            /// Contact's name from address book
            let playerName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
            
            if ABPersonHasImageData(record) {
                /// New person's image if exists
                let imgData = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatOriginalSize).takeRetainedValue()
                cell.imageView!.image = UIImage(data: imgData)
            }
            cell.playerNameLabel.text = "\(playerName)"
        } else {
            cell.playerNameLabel.text = "Access denied"
        }
        
        return cell
    }

    /**
    Get players' names from the final list.
    
    :param: row Int index of a person
    */
    func process(row: Int) {
        /// Contact entry for the person
        let record: ABRecordRef = contactList!.objectAtIndex(row)
        
        /// Blank image as a template
        var image: UIImage = UIImage(named: "blank_user")
        
        if ABPersonHasImageData(record) {
            /// New person's image if exists
            let imgData = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatOriginalSize).takeRetainedValue()
            image = UIImage(data: imgData)
        }
        
        /// Contact's name from address book
        let playerName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
        
        delegate!.personFromAddressBookDidSelected(self, name: playerName, image: image)
    }

    @IBAction func addPlayersAction(sender: UIBarButtonItem) {
        
        for person in selectedPersons {
            process(person)
        }
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    

}
