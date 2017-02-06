//
//  ContactController.swift
//  Contacts
//
//  Created by Keaton Harward on 1/13/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation

class ContactController {
    static let shared = ContactController()
    
    private let cloudKitManager = CloudKitManager()
    
    var delegate: ContactControllerDelegate?
    
    var contacts = [Contact]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.contactsUpdated()
            }
        }
    }
    
    init() {
        fetchContacts()
    }
    
    //MARK: - Create
    
    func saveContact(name: String, phone: String, email: String) {
        
        let contact = Contact(name: name, phone: phone, email: email)
        let record = contact.ckRecordRepresentation
        
        cloudKitManager.saveRecord(record) { (record, error) in
            if let error = error {
                print("Unable to save record with CloudKit. \(error.localizedDescription)")
            }
            if record != nil {
                print("Record saved to CloudKit.")
            }
        }
        contacts.append(contact)
        contacts.sort { (x, y) -> Bool in
            x.name > y.name
        }
    }
    
    //MARK: - Read
    
    func fetchContacts() {
        
        let sortDescriptor = NSSortDescriptor(key: Keys.shared.nameKey, ascending: false)
        
        cloudKitManager.fetchRecordsWithType(Keys.shared.recordKey, sortDescriptors: [sortDescriptor], recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("There was an error fetching records from CloudKit. \(error.localizedDescription)")
            }
            if let records = records {
                self.contacts = records.flatMap { Contact(record: $0) }
            }
        }
        
    }
    
    //MARK: - Update
    
    func updateContact(contact: Contact, name: String, phone: String, email: String) {
        
        contact.name = name
        contact.phone = phone
        contact.email = email
        let record = contact.ckRecordRepresentation
        
        
        cloudKitManager.modifyRecords([record], perRecordCompletion: nil) { (record, error) in
            if let error = error {
                print("There was an error updating the record in CloudKit. \(error.localizedDescription)")
            }
            // TODO: - figure out how to update the contact we're editing in the contacts array.
        }
    }
    
}


protocol ContactControllerDelegate {
    func contactsUpdated()
}





