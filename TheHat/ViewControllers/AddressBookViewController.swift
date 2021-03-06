//
//  AddressBookViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 29/11/14.
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
    func personFromAddressBookDidSelected(controller: AddressBookViewController, name: String, image: UIImage)
}

class AddressBookViewController: BaseViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource {
    
    /// Address book reference
    var addressBook: ABAddressBookRef?
    
    /// Delegate for the addition of a new person
    var delegate: PersonFromAddressBookDelegate? = nil
    
    /// List of persons from address book
    var contactList: NSArray?
    
    /// List of selected persons
    var selectedPersons = [ABRecordID]()
    var filteredPersons = [ABAddressBookRef]()
    
    /// Button to add a list of persons to the dict
    @IBOutlet weak var addPlayersButton: UIBarButtonItem!
    
    /// Search bar
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Main table view
    @IBOutlet weak var tableView: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate != nil) {
            
            var cell = tableView.cellForRowAtIndexPath(indexPath) as AddressBookTableViewCell
            let personId = cell.idx
            
            if (cell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                cell.accessoryType = UITableViewCellAccessoryType.None
                selectedPersons = selectedPersons.filter({$0 != personId})
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                selectedPersons.append(personId!)
            }
        }
    }
    
    /**
        Determines a list of contacts.
    
        :param: tableView Addres Book table
        :param: section Number of rows in section
        :returns: Int number of contacts in addres book or 1 if access restricted
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (contactList != nil) {
            if tableView == self.searchDisplayController!.searchResultsTableView {
                return self.filteredPersons.count
            } else {
                return contactList!.count // If address book was parsed successfuly
            }
        }
        return 1
    }
    
    /**
    Creates a new cell.
    
        :param: tableView Address book table
        :param: indexPath Index of a new cell
        :return: AddressBookTableViewCell with a new player of "access denied" message
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /// A new cell to be returned
        
        var cell: AddressBookTableViewCell
        
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            cell = self.tableView.dequeueReusableCellWithIdentifier("AddressBookCell") as AddressBookTableViewCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("AddressBookCell", forIndexPath: indexPath) as AddressBookTableViewCell
        }
        
        // If access granted
        if (contactList != nil) {
            
            var record: ABRecordRef
            
            /// Contact entry for the person
            if (tableView == self.searchDisplayController!.searchResultsTableView) && (filteredPersons.count > 0) {
                record = filteredPersons[indexPath.row]
            } else {
                record = contactList![indexPath.row]
            }
           
            cell.idx = getId(record)
            
            /// Contact's name from address book
            let playerName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
            
            if ABPersonHasImageData(record) {
                /// New person's image if exists
                let imgData = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatOriginalSize).takeRetainedValue()
                cell.playerImageView.image = UIImage(data: imgData)
            }
            cell.playerNameLabel.text = "\(playerName)"
        } else {
            cell.playerNameLabel.text = "Access denied"
        }
        
        return cell
    }
    
    /**
        Get contact's data by an index of a cell.
    
        :param: row Int index of a person
    */
    func process(record: ABRecordRef) {
        
        /// Blank image as a template
        var image: UIImage = UIImage(named: "blank_user")!
        
        if ABPersonHasImageData(record) {
            /// New person's image if exists
            let imgData = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatOriginalSize).takeRetainedValue()
            image = UIImage(data: imgData)!
        }
        
        /// Contact's name from address book
        let playerName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
        
        delegate!.personFromAddressBookDidSelected(self, name: playerName, image: image)
    }
    
    /**
        Get players' names from the final list and dismiss current view controller.
    */
    func performExitFromView() {
        for person in selectedPersons {
            process(getRecord(person))
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
        Returns to the previous view.
    
        :param: sender UIBarButtonItem
    */
    @IBAction func addPlayersAction(sender: UIBarButtonItem) {
        performExitFromView()
    }

    
    // MARK: - Search
    
    /**
        Creates a list of filtered persons to work with.
    
        :param: searchText String text to search.
    */
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredPersons = (self.contactList as Array).filter({( person: ABRecordRef) -> Bool in
            let nameMatch = ABRecordCopyCompositeName(person).takeRetainedValue() as NSString
            return ((nameMatch as String).rangeOfString(searchText) != nil)
        })
    }
    
    /**
        Reloads table to provide new search results.
    
        :param: controller UISearchDisplayController
        :param: searchString String
    */
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    /**
        Reloads table for search scope.
    
        :param: controller UISearchDisplayController
        :param: searchOption Int
    */
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    /**
        Returns contact's unique id.
    
        :param: record ABRecordRef
        :returns: ABRecordID idx of the contact
    */
    func getId(record: ABRecordRef) -> ABRecordID {
        return ABRecordGetRecordID(record)
    }
    
    /**
        Returns contact by the unique id.
    
        :param: id ABRecordID
        :returns: ABRecordRef object of the contact
    */
    func getRecord(id: ABRecordID) -> ABRecordRef {
        
        var person = ABAddressBookGetPersonWithRecordID(addressBook, id)
        var personRef: ABRecordRef = Unmanaged<NSObject>.fromOpaque(person.toOpaque()).takeUnretainedValue() as ABRecordRef
        
        return personRef
    }
    
    /**
        Returns to the previous view.
    
        :param: sender UIBarButtonItem
    */
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        performExitFromView()
    }
}
