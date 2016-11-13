//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Cody Condon on 2016-11-13.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String,Operation> = [
    "π": Operation.Constant(M_PI),
    "e": Operation.Constant(M_E),
    "√": Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    "X": Operation.BinaryOperation({ $0 * $1}),
    "/": Operation.BinaryOperation({$0 / $1}),
    "+": Operation.BinaryOperation({$0 + $1}),
    "-": Operation.BinaryOperation({$0 - $1}),
    "=": Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case.Constant(let value): accumulator = value
            case.UnaryOperation(let function): accumulator = function(accumulator)
            case.BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case.Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()  {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
            
        
    }
    
    var result: Double {
        get {
           return accumulator
        }
    }
    
}
