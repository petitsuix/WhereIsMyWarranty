//
//  ExtensionUITextField.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit

extension UITextField {
    // ⬇︎ Adds "Done" to keyboard
    func addDoneToolbar() {
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)) // Defining toolbar and its boundaries
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "OK", style: .done, target: target, action: #selector(doneButtonTapped))
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar // Assigning toolbar to the reference's dedicated Accessory View
    }
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

extension UITextView {
    func addDoneToolbar() {
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "OK", style: .done, target: target, action: #selector(doneButtonTapped))
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

