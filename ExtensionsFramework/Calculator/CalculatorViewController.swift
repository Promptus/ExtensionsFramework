//
//  CalculatorViewController.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/16/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import UIKit
import Foundation

open class CalculatorViewController: UIViewController, EditedLabelDelegate, DisplayTemporaryValueDelegate {
    
    @IBOutlet var rightSideButtons: [UIButton]! {
        didSet {
            for button in rightSideButtons {
                button.backgroundColor = themeColor
            }
        }
    }
    
    @IBOutlet weak var displayLabel: CopyableLabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var userInTheMiddleOfTypingNumber = false
    var calculatorOperations = CalculatorOperations()
    fileprivate var themeColor = UIColor.green
    
    @IBAction func enter() {
        appendDigit()
    }
    
    @IBAction func turnIntoDouble() {
        if displayLabel.text!.range(of: ",") == nil {
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
    
    @IBAction func pressedDigit(_ sender: UIButton) {
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
    
    @IBAction func operate(_ sender: UIButton) {
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
    fileprivate func appendDigit() {
        userInTheMiddleOfTypingNumber = false
        calculatorOperations.pushOperand(displayValue)
    }
    
    //MARK - helper method that changes the clearButton title
    fileprivate func changeClearButtonTitle(_ title: String) {
        clearButton.setTitle(title, for: UIControl.State.normal)
    }
    
    //MARK - computed property were we format the display value
    var displayValue:Double {
        get {
            var displayText = displayLabel.text! as String
            displayText = displayText.replacingOccurrences(of: ",", with: ".")
            if displayText.hasSuffix(".") {
                displayText = displayText + "0"
            }
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let numberString = numberFormatter.number(from: displayText) {
                return numberString.doubleValue
            }
            return 0
        } set {
            //check for integer value
            let isInteger = newValue.truncatingRemainder(dividingBy: 1) == 0
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
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                numberFormatter.maximumFractionDigits = 15
                let tempDisplayString = numberFormatter.string(from: NSNumber(value: newValue))!
                
                let array = tempDisplayString.components(separatedBy: ",")
                var tempDisplayText = "0" as String
                
                if let string = array.last {
                    if string != "0" {
                        tempDisplayText = String(format: "%.\(string.utf16.count)f", newValue)
                    }
                }
                tempDisplayText = tempDisplayText.replacingOccurrences(of: ".", with: ",")
                displayLabel.text = tempDisplayText
            }
            userInTheMiddleOfTypingNumber = false
        }
    }
    
    //MARK - EditedLabelDelegate method(notifies when a value was pasted inside the label)
    func valueWasPastedInsideLabel(_ value:String) {
        userInTheMiddleOfTypingNumber = true
        calculatorOperations.lastUsedOperand = nil
    }
    
    //MARK - DisplayTemporaryValueDelegate method(used to show a temporary result value while doing multiple operations from the stack)
    func displayTemporaryValue(_ value: Double?) {
        if let val = value {
            displayValue = val
        }
    }
    
    @objc public init(withThemeColor: UIColor) {
        themeColor = withThemeColor
        let bundle = Bundle(for: CalculatorViewController.self)
        super.init(nibName: "CalculatorViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.editDelegate = self
        calculatorOperations.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Google Analytics tracker
        //GAIUtils.sendView(TrackedScreensConstants.trackedCalculatorScreen())
        
//        let tracker = GAI.sharedInstance().defaultTracker as GAITracker
//        let build = GAIDictionaryBuilder.createScreenView().set("Calculator View", forKey: kGAIScreenName).build() as NSDictionary
//        tracker.send(build as [NSObject : AnyObject])
    }
    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
