//
//  CalculatorViewController.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/16/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import UIKit
import Foundation

public class CalculatorViewController: UIViewController, EditedLabelDelegate, DisplayTemporaryValueDelegate {
    
    @IBOutlet weak var displayLabel: CopyableLabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var userInTheMiddleOfTypingNumber = false
    
    var calculatorOperations = CalculatorOperations()
    
    @IBAction func enter() {
        appendDigit()
    }
    
    @IBAction func turnIntoDouble() {
        if displayLabel.text!.rangeOfString(",") == nil {
            displayLabel.text = displayLabel.text! + ","
        }
        userInTheMiddleOfTypingNumber = true
    }
    
    @IBAction func changeSignAction() {
        displayValue = -displayValue;
        if displayValue != 0 {
            userInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func equalSignPressed() {
        if let result = calculatorOperations.performEqualOp(displayValue) {
            displayValue = result
        }
    }
    
    @IBAction func clearButtonPressed() {
        calculatorOperations.clearStack()
        changeClearButtonTitle("AC")
        displayLabel.text = "0"
        userInTheMiddleOfTypingNumber = false
    }
    
    @IBAction func pressedDigit(sender: UIButton) {
        changeClearButtonTitle("C")
        
        let digit = sender.currentTitle!
        
        if userInTheMiddleOfTypingNumber == true {
            displayLabel.text = displayLabel.text! + digit
        } else {
            if digit != "0" || displayLabel.text != "0" {
                userInTheMiddleOfTypingNumber = true
                displayLabel.text = digit
            }
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingNumber == true || displayLabel.text == "0" {
            appendDigit()
        }
        if let operation = sender.currentTitle {
            if let result = calculatorOperations.performOperation(operation) {
                print("\(result)")
                if result.isNaN == false {
                    displayValue = result
                } else {
                    calculatorOperations.clearStack()
                }
            }
        }
    }
    
    //MARK - pushes operands onto the operand stack
    private func appendDigit() {
        userInTheMiddleOfTypingNumber = false
        calculatorOperations.pushOperand(displayValue)
    }
    
    //MARK - helper method that changes the clearButton title
    private func changeClearButtonTitle(title: String) {
        clearButton.setTitle(title, forState: UIControlState.Normal)
    }
    
    //MARK - computed property were we format the display value
    var displayValue:Double {
        get {
            var displayText = displayLabel.text! as String
            displayText = displayText.stringByReplacingOccurrencesOfString(",", withString: ".")
            if displayText.hasSuffix(".") {
                displayText = displayText + "0"
            }
            let numberFormatter = NSNumberFormatter()
            numberFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            if let numberString = numberFormatter.numberFromString(displayText) {
                return numberString.doubleValue
            }
            return 0
        } set {
            //check for integer value
            let isInteger = newValue % 1 == 0
            if isInteger {
                var intValue: Int64 = 0
                
                //Int64 max value validation to prevent exception
                if newValue <= Double(Int64.max) {
                    intValue = Int64(newValue)
                } else {
                    calculatorOperations.clearStack()
                }
                displayLabel.text = "\(intValue)"
            } else {
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                numberFormatter.maximumFractionDigits = 15
                let tempDisplayString = numberFormatter.stringFromNumber(newValue)!
                
                let array = tempDisplayString.componentsSeparatedByString(",")
                var tempDisplayText = "0" as String
                
                if let string = array.last {
                    if string != "0" {
                        tempDisplayText = String(format: "%.\(string.utf16.count)f", newValue)
                    }
                }
                tempDisplayText = tempDisplayText.stringByReplacingOccurrencesOfString(".", withString: ",")
                displayLabel.text = tempDisplayText
            }
            userInTheMiddleOfTypingNumber = false
        }
    }
    
    //MARK - EditedLabelDelegate method(notifies when a value was pasted inside the label)
    func valueWasPastedInsideLabel(value:String) {
        userInTheMiddleOfTypingNumber = true
        calculatorOperations.lastUsedOperand = nil
    }
    
    //MARK - DisplayTemporaryValueDelegate method(used to show a temporary result value while doing multiple operations from the stack)
    func displayTemporaryValue(value: Double?) {
        if let val = value {
            displayValue = val
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.editDelegate = self
        calculatorOperations.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Google Analytics tracker
        //GAIUtils.sendView(TrackedScreensConstants.trackedCalculatorScreen())
        
//        let tracker = GAI.sharedInstance().defaultTracker as GAITracker
//        let build = GAIDictionaryBuilder.createScreenView().set("Calculator View", forKey: kGAIScreenName).build() as NSDictionary
//        tracker.send(build as [NSObject : AnyObject])
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
