
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
    var lastNum: Float = 0.0

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
        } else if (numberDisplayLabel!.text! == "0" && keyValue != ".") {
            numberDisplayLabel!.text! = keyValue
        } else {
            numberDisplayLabel!.text! += keyValue
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
            curOperator = ""   // press "=" continuously
            operatorJustPressed = true
        case "+/-":
            numberDisplayLabel!.text! = floatToStr(-numberDisplayValue)
            curOperator = ""
            operatorJustPressed = false
        default:
            if operatorJustPressed && curOperator != sender.titleLabel!.text! {
            } else {
                if operatorJustPressed && curOperator == sender.titleLabel!.text! {
                    curValue = getCalculationResult(curValue, num2: lastNum, opr: curOperator)
                } else {
                    curValue = getCalculationResult(curValue, num2: numberDisplayValue, opr: curOperator)
                }
            }
            curOperator = sender.titleLabel!.text!
            operatorJustPressed = true
        }
        
        lastNum = numberDisplayValue
    }
    
    func strToFloat(str: String) -> Float {
        return Float(str)!
    }
    
    func floatToStr(num: Float) -> String {
        if num == 0.0 {
            return "0"
        } else {
            var s = String(num)
            if s.hasSuffix(".0") {
                let index = s.endIndex.advancedBy(-2)
                s = s.substringToIndex(index)
            }
            return s
        }
    }
    
    func displayCurValue() {
        if curValue == 0.0 {
            numberDisplayLabel.text! = "0"
            return
        }
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

