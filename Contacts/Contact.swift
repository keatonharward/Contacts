//
//  Contact.swift
//  Contacts
//
//  Created by Keaton Harward on 1/13/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    var name: String
    var phone: String
    var email: String
    
    init(name: String, phone: String, email: String) {
        self.name = name
        self.phone = phone
        self.email = email
    }
    
    convenience init?(record: CKRecord) {
        guard let name = record[Keys.shared.nameKey] as? String,
            let phone = record[Keys.shared.phoneKey] as? String,
            let email = record[Keys.shared.emailKey] as? String else { return nil }
        self.init(name: name, phone: phone, email: email)
    }
    
    var ckRecordRepresentation: CKRecord {
        let record = CKRecord(recordType: Keys.shared.recordKey)
        
        record[Keys.shared.nameKey] = name as CKRecordValue?
        record[Keys.shared.phoneKey] = phone as CKRecordValue?
        record[Keys.shared.emailKey] = email as CKRecordValue?
        
        return record
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return
            lhs.name == rhs.name
    }
}
