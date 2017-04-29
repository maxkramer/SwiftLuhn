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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var validityLabel: UILabel!

    //src: http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm
    let americanExpress          = "378282246310005"
    let americanExpress2         = "371449635398431"
    let americanExpressCorporate = "378734493671000"
    let australianBankCard       = "5610591081018250"
    let dinersClub               = "30569309025904"
    let dinersClub2              = "38520000023237"
    let discover                 = "6011111111111117"
    let discover2                = "6011000990139424"
    let jCB                      = "3530111333300000"
    let jCB2                     = "3566002020360505"
    let masterCard               = "5555555555554444"
    let masterCard2              = "5105105105105100"
    let visa                     = "4111111111111111"
    let visa2                    = "4012888888881881"
    let visa3                    = "4222222222222"

    // src: http://www.dicastech.net/numeros-de-cartoes-de-credito-para-testes/
    let aura                     = "5078601870000127985"
    let aura2                    = "5078601800003247449"
    let eloo                     = "636297000045701"

    // src: http://www.geradorcartaodecredito.com.br/hipercard
    let hipercard                = "6062825756950756"

    override func viewDidLoad() {
        super.viewDidLoad()

        let initialValue = visa2

        cardTextField.text = initialValue
        updateValidityLabel(initialValue.isValidCardNumber())
        updateTypeLabel(initialValue)
    }
    
    private func updateValidityLabel(_ isValid: Bool) {
        if isValid {
            validityLabel.text = "VALID"
            validityLabel.textColor = UIColor.green
        }
        else {
            validityLabel.text = "INVALID"
            validityLabel.textColor = UIColor.red
        }
    }

    private func updateTypeLabel(_ string: String) {
        if let type = string.cardType() {
            typeLabel.text = type.stringValue()
        } else {
            typeLabel.text = "Unknown"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text ?? "") as NSString
        
        let updatedString = text.replacingCharacters(in: range, with: string)
        
        let isValid = updatedString.isValidCardNumber()
        updateValidityLabel(isValid)

        updateTypeLabel(updatedString)

        return true
    }
    
}
