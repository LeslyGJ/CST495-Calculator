//
//  ViewController.swift
//  Calculator
//
//  Created by Lesly Garcia on 9/14/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    
    var userIsInTheMiddleOfTypingNumber: Bool = false
    let initialDisplay = "0"
    
    @IBAction func apppendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." || display.text!.range(of:".") == nil {
            display.text = display.text! + digit
        }
        
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        }
            
        else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
        appendHistory(text: digit) //
    }

    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "−": performOperation {$1 - $0}
            case "√": prerformOperation {sqrt($0)}
            case "sin": prerformOperation{sin($0)}
            case "cos": prerformOperation {cos($0)}
            case "π": prerformOperation {$0 * M_PI}
            default: break
        }
        
        appendHistory(text: " " + operation + " ")
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func prerformOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>() //initialize empty array
    var historyStack = Array<String>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
    }
    
    @IBAction func clear(_ sender: UIButton) {
        operandStack.removeAll(keepingCapacity: false)
        //userIsInTheMiddleOfTypingNumber = false
        display.text = initialDisplay
        history.text = ""
    }
    
    func appendHistory(text: String) {
        history.text = history.text! + text;
    }
    
    
    //computed properties
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = true
        }
    }

}

