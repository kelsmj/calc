//
//  ViewController.swift
//  Calculator
//
//  Created by Matt Kelsey on 12/12/15.
//  Copyright © 2015 LabelNexus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber  = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsInTheMiddleOfTypingNumber) {
            display.text = display.text! + digit
        } else {
            display.text = digit;
            userIsInTheMiddleOfTypingNumber = true
        }
        print("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
//        let operation = sender.currentTitle!
        if(userIsInTheMiddleOfTypingNumber) {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
//        switch operation
//        {
//        case "×":performOperation { $0 * $1 }
//        case "÷":performOperation { $1 / $0 }
//        case "+":performOperation { $0 + $1 }
//        case "−":performOperation { $0 - $1 }
//        case "√":performOperation { sqrt($0)}
//        default:break
//        }
    }
    
    var operandStack = Array<Double>()
//    func performOperation(operation: (Double, Double) -> Double) {
//        if operandStack.count >= 2 {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//        
//    }
//    
//    @nonobjc
//    func performOperation(operation: Double -> Double) {
//        if operandStack.count >= 1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//        
//    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        //operandStack.append(displayValue)
        //print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}

