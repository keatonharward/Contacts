//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Keaton Harward on 1/13/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, ContactControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.shared.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        
        return cell
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactDetail" {
            guard let contactDetailVC = segue.destination as? ContactDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let contact = ContactController.shared.contacts[indexPath.row]
            
            contactDetailVC.contact = contact
        }
    }
    
    func contactsUpdated() {
        tableView.reloadData()
        
    }
    
}

