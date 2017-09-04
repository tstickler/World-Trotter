//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tyler Stickler on 8/29/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    // Variable that allows us to reference our text field and label
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var isReallyLabel: UILabel!
    
    // Implements a number formatter, preventing the display of more
    // than two digits after the decimal point
    let numberFormatter: NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // This variable is assigned as the user inputs numbers into 
    // the text field. It then updates the celsius label
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    // If fahrenheit value is not nil, converts the fahrenheit 
    // value into celsius. Otherwise, returns nil.
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    // Function that addresses the value of the text field being
    // changed. If the user enters a number, it assigns the value
    // as the fahrenheit degrees. If left blank, fahrenhiet is nil.
    @IBAction func fahrenheightFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    // Dismisses the numberpad if the user taps on the background
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    // Function that updates the celsius label. If there is a value for
    // celsius, we set the label's text to hold that value and only format
    // for one decimal. If celsiusValue is nil, the label is ???
    func updateCelsiusLabel() {
        if let celsiusVal = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusVal.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    // Delegate that doesn't allow the user to enter multiple decimals
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Determines the current user locale
        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeperator)
        
        if existingTextHasDecimalSeperator != nil,
            replacementTextHasDecimalSeperator != nil {
            return false
        }
        else {
            if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) || (string.range(of: ".") != nil) {
                return true
            }
            else {
                return false
            }
        }
    }
    
    // Updates the label so that it displays ??? when the app opens
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        
        updateCelsiusLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Var to hold single point in time
        let date = Date()
        
        // Used to make sense of date variable
        let cal = Calendar.current
        
        // Sets hour according to the calendar and date
        let hour = cal.component(.hour, from: date)
        
        print("Current hour is: \(hour)")
        
        // Checks if we are between 8pm and 5am
        if hour >= 20 || hour < 5 {
            // Sets the background to black
            view.backgroundColor = UIColor.black
            
            // Changes dark labels to white so they can be read
            isReallyLabel.textColor = UIColor.white
            textField.attributedPlaceholder = NSAttributedString(string: "Value",
                                                                 attributes: [NSForegroundColorAttributeName: UIColor.white])
        }
    }
}
