
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
    
    var stack = Stack<Float>()
    var curOperator: String = ""
    var operatorJustPressed: Bool = true
    var lastNum: Float = 0.0
    var equalButtonJustPressed: Bool = true
    var lastSender: UIButton?
    var lastSenderTextColor: UIColor?
    var lastSenderBackgroundColor: UIColor?

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
        setTextAndBackgroundColor(sender)
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
        equalButtonJustPressed = false
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        setTextAndBackgroundColor(sender)
        self.stack.clear()
        lastNum = 0.0
        curOperator = ""
        operatorJustPressed = true
        equalButtonJustPressed = true
        displayResult()
    }
    
    @IBAction func operatorButtonPressed(sender: UIButton) {
        setTextAndBackgroundColor(sender)
        let numberDisplayValue = strToFloat(numberDisplayLabel!.text!)
        let opr = sender.titleLabel!.text!
        
        switch opr {
        case "=":
            var res: Float
            if stack.isEmpty() {
                res = numberDisplayValue
            } else {
                if equalButtonJustPressed {
                    res = getCalculationResult(stack.pop(), num2: lastNum, opr: curOperator)
                } else {
                    res = getCalculationResult(stack.pop(), num2: numberDisplayValue, opr: curOperator)
                    lastNum = numberDisplayValue
                }
            }
            stack.push(res)
            displayResult()
            equalButtonJustPressed = true
        case "+/-":
            stack.push(-numberDisplayValue)
            displayResult()
            curOperator = opr
            lastNum = numberDisplayValue
            equalButtonJustPressed = false
        default:
            if curOperator != "" && !equalButtonJustPressed {
                let res = getCalculationResult(stack.pop(), num2: numberDisplayValue, opr: curOperator)
                stack.push(res)
            } else {
                stack.push(numberDisplayValue)
            }
            curOperator = opr
            lastNum = numberDisplayValue
            equalButtonJustPressed = false
        }
        operatorJustPressed = true
    }
    
    private func isOperator(str: String) -> Bool {
        return ["+", "-", "x", "÷", "+/-", "="].contains(str)
    }
    
    private func strToFloat(str: String) -> Float {
        return Float(str)!
    }
    
    private func floatToStr(num: Float) -> String {
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
    
    private func displayResult() {
        if self.stack.isEmpty() {
            numberDisplayLabel.text! = "0"
        } else {
            numberDisplayLabel.text! = floatToStr(stack.peek())
        }
    }
    
    private func getCalculationResult(num1: Float, num2: Float, opr: String) -> Float {
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
    
    private func setTextAndBackgroundColor(sender: UIButton) {
        if lastSender != nil {
            lastSender!.titleLabel?.textColor = lastSenderTextColor
            lastSender!.backgroundColor = lastSenderBackgroundColor
        }
        lastSender = sender;
        lastSenderTextColor = sender.titleLabel!.textColor!
        lastSenderBackgroundColor = sender.backgroundColor!
        sender.showsTouchWhenHighlighted = true
        sender.titleLabel?.textColor = UIColor.whiteColor()
        sender.backgroundColor = UIColor.orangeColor()
    }
}

