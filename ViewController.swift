//
//  ViewController.swift
//  Calculator
//
//  Created by GSameen on 2017/9/2.
//  Copyright © 2017年 Sameen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false     //为了不显示0
    
    @IBAction func Clear(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        display!.text! = "0"
        RealTimeDisplay!.text! = "Real Time Display"
    }
    @IBOutlet weak var RealTimeDisplay: UILabel!
    
    
    
    @IBAction func touchDight(_ sender: UIButton) {
        let digit = sender.currentTitle!  //发送UIButton上的字符
        //如果用户输入 把输入存为操作数
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            if display!.text!.contains(".") && digit == "."{
                display!.text! = textCurrentlyInDisplay
            }else{
                display!.text! = textCurrentlyInDisplay + digit
            }
        }else{
            if digit != "0" && digit != "."{
                display!.text! = digit
            }else{
                display!.text! = "0."
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    
    var displayValue: Double{    // 计算属性 read only
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)  // 计算属性中的特殊变量
            //总是等于 赋值语句右边的 你让变量等于的那个值
        }
    }
    
    //私有model 在controller中示例化model
    // 将计算模块全部交给model处理
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        //如果用户输入 将把用户输入内容存为操作符
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{  //?值 不能直接等于
            displayValue = result
        }
        
    }
    
 
    
}



