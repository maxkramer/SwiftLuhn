//
//  ViewController.swift
//  SwiftLuhn
//
//  Created by Max Kramer on 03/29/2016.
//  Copyright (c) 2016 Max Kramer. All rights reserved.
//

import UIKit
import SwiftLuhn

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var validityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTextField.text = "378282246310005"
        updateLabel(cardTextField.text!.isValidCardNumber())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateLabel(isValid: Bool) {
        if isValid {
            validityLabel.text = "VALID"
            validityLabel.textColor = UIColor.greenColor()
        }
        else {
            validityLabel.text = "INVALID"
            validityLabel.textColor = UIColor.redColor()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text ?? "") as NSString
        
        let updatedString = text.stringByReplacingCharactersInRange(range, withString: string)
        
        let isValid = updatedString.isValidCardNumber()
        updateLabel(isValid)
        return true
    }

}

