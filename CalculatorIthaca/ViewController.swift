
//
//  ViewController.swift
//  CalculatorIthaca
//
//  Created by Haofei Ying on 9/10/16.
//  Copyright © 2016 Haofei Ying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberDisplayLabel: UILabel!
    
    var curValue: Float = 0
    var curOperator: String = ""
    var operatorJustPressed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberDisplayLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numpadButtonPressed(sender: UIButton) {
        let keyValue = sender.titleLabel!.text!
        
        if operatorJustPressed {
            numberDisplayLabel.text = ""
        }
        if (keyValue == "." && numberDisplayLabel.text!.rangeOfString(".") != nil) {
        } else {
            numberDisplayLabel.text! += keyValue
        }
        
        operatorJustPressed = false
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        numberDisplayLabel.text = "0"
        curValue = 0
        curOperator = ""
    }
    
    @IBAction func operatorButtonPressed(sender: UIButton) {
        let numberDisplayValue = strToFloat(numberDisplayLabel!.text!)
    
        switch sender.titleLabel!.text! {
        case "=":
            curValue = getCalculationResult(curValue, num2: numberDisplayValue, opr: curOperator)
            displayCurValue()
            curOperator = ""   // press "=" continuesly
        case "+/-":
            curValue = -curValue
            displayCurValue()
            curOperator = ""
        default:
            if operatorJustPressed {
                displayCurValue()
            } else {
                curValue = getCalculationResult(curValue, num2: numberDisplayValue, opr: curOperator)
                displayCurValue()
            }
            curOperator = sender.titleLabel!.text!
        }
        
        operatorJustPressed = true
    }
    
    func strToFloat(str: String) -> Float {
        return Float(str)!
    }
    
    func displayCurValue() {
        let s = String(curValue)
        if s.hasSuffix(".0") {
            let index = s.endIndex.advancedBy(-2)
            numberDisplayLabel.text! = s.substringToIndex(index)
        } else {
            numberDisplayLabel.text! = s
        }
    }
    
    func getCalculationResult(num1: Float, num2: Float, opr: String) -> Float {
        switch opr {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "x":
            return num1 * num2
        case "÷":
            return num1 / num2
        case "%":
            return num1 % num2
        default:   // no operator is set, just return the current display value
            return num2
        }
    }
    
}

