//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Ash Ryan Arnwine on 7/17/16.
//  Copyright © 2016 Ash Ryan Beats. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        print("Conversion loaded")
    }
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    var celciusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * 5/9
        }
        else {
            return nil
        }
    }
    
    func updateCelciusLabel() {
        if let value = celciusValue {
            celciusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celciusLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func fahrenheitFildEditingChanged(textfield: UITextField) {
        
        if let text = textfield.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func dismissKeyboardResponder(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
}
