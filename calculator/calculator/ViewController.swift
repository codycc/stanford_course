//
//  ViewController.swift
//  calculator
//
//  Created by Cody Condon on 2016-11-11.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet private weak var display: UILabel!
    var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyinDisplay = display.text!
            display.text = textCurrentlyinDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var displayValue: Double {
        get {
           return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBAction private func performOperation(_ sender: UIButton) {
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                displayValue = M_PI
            } else if mathematicalSymbol == "√" {
                displayValue = sqrt(displayValue)
            }
        }
        
    }
}

