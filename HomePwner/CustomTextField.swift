//
//  CustomTextField.swift
//  HomePwner
//
//  Created by Brandon Kimberlin on 4/1/19.
//  Copyright © 2019 Brandon Kimberlin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        borderStyle = .bezel
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .roundedRect
        return super.resignFirstResponder()
    }
}
