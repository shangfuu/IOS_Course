//
//  ViewController.swift
//  Calculator
//
//  Created by mac08 on 2020/3/5.
//  Copyright © 2020 mac08. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var display: UILabel!
    
    // touch digit
    var firstDigit = true
    // performOperation
    var op1 = 0.0
    var symbolOP = ""
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(digit) was clicked")
        
        if firstDigit{
            display.text = digit
            firstDigit = false
        }
        else{
            let textcurrentlyInDisplay = display.text!
            display.text = textcurrentlyInDisplay + digit
        }
        
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        let Operation = sender.currentTitle
        switch Operation {
        case "AC":
            display.text = "0"
            firstDigit = true
        case "√":
            let operand = Double(display.text!)!
            display.text = String(sqrt(operand))
            firstDigit = true
        case "+/-":
            let operand = Double(display.text!)!
            display.text = String(-operand)
        case "%":
            op1 = Double(display.text!)!
            firstDigit = true
            symbolOP = "%"
        case "+":
            op1 = Double(display.text!)!
            firstDigit = true
            symbolOP = "+"
        case "-":
            op1 = Double(display.text!)!
            firstDigit = true
            symbolOP = "-"
        case "×":
            op1 = Double(display.text!)!
            firstDigit = true
            symbolOP = "×"
        case "÷":
            op1 = Double(display.text!)!
            firstDigit = true
            symbolOP = "÷"
        case "=":
            print(symbolOP)
            if (symbolOP != "") {
                let op2 = Double(display.text!)!
                switch symbolOP {
                case "%":
                    display.text = String(Int(op1) % Int(op2))
                case "+":
                    display.text = String(op1 + op2)
                case "-":
                    display.text = String(op1 - op2)
                case "×":
                    display.text = String(op1*op2)
                case "÷":
                    display.text = String(op1/op2)
                default:
                    break
                }
                firstDigit = true
                symbolOP = ""
            }
        default:
            break
        }
        
    }
}

