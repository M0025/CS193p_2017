//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by GSameen on 2017/9/2.
//  Copyright © 2017年 Sameen. All rights reserved.
//

import Foundation

// 结构体自带构造器 初始化所有未初始化属性 类不行
struct CalculatorBrain {
    
    // 一个执行数学运算的方法 通过符号来判断要执行什么运算
    // 实参标签为空
    private var accumulator: Double?
    
    
    //  枚举 可以存放各种类型 一个类型的合集 没个枚举类型都有一个关联值类型
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "tan" : Operation.unaryOperation(tan),
        "±" : Operation.unaryOperation({ -$0 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),  //闭包
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals
    ]
    
    //计算方法 获取符号
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            // 不会进入下一个case
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperaion()
            }
        }
    }
    

    
    private var pendingBinaryOperation: PendingBinaryOperation?
   
    
    // 即将完成二元运算
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        // 实参标签“with“ 形参名称secondOperand
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        // 返回是否有二元运算符等待
//        func resultIsPending() -> Bool{
//            if firstOperand != nil && pendingBinaryOperation != nil {
//                return true
//            }else{
//                return false
//            }
//        }

    }
    // 显示二元运算结果
    private mutating func performPendingBinaryOperaion(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }

    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
        
    }
    
    var result: Double?{   //计算属性 只读 获得结果
        get{
            return accumulator
        }
    }
    
//    var description: String{
//        get{
//            accumulator
//        }
//    }
    
}



    /* switch symbol {
     case "π":
     accumulator = Double.pi
     display!.text = String(Double.pi)
     //string构造器 返回值是一个string？能转转 转不了拉倒
     case "√":
     let operand = Double(display!.text!)!//double 构造器（init）
     if let operand = accumulator{
     accumulator = sqrt(operand)
     }
     
     default:
     break */
    
    
    //获取计算数 设置操作数

