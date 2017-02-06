//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Keaton Harward on 1/13/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var contact: Contact?
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let phone = phoneTextField.text,
            let email = emailTextField.text else { return }
        
        if contact == nil {
            ContactController.shared.saveContact(name: name, phone: phone, email: email)
            ContactController.shared.contacts.append(Contact(name: name, phone: phone, email: email))
            ContactController.shared.contacts.sort(by: { (x, y) -> Bool in
                return x.name > y.name
            })
        } else {
            guard let contact = contact else { return } // I think this is a place where implicit unwrapping would be acceptable, but I figured I should avoid the ! until I consulted someone. Is that the case?
            ContactController.shared.updateContact(contact: contact, name: name, phone: phone, email: email)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        nameTextField.text = contact?.name
        phoneTextField.text = contact?.phone
        emailTextField.text = contact?.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
}
