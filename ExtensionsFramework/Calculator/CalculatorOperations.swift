//
//  CalculatorOperations.swift
//  kemmler
//
//  Created by Razvan Benga on 2/16/15.
//  Copyright (c) 2015 Promptus. All rights reserved.
//

import Foundation

let kMultiply = "×"
let kDivide = "÷"
let kPlus = "+"
let kMinus = "−"
let kPercentage = "%"

protocol DisplayTemporaryValueDelegate: class {
    func displayTemporaryValue(value: Double?)
}

class CalculatorOperations
{
    private enum Operation: CustomStringConvertible {
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var operationStack = [Double]()
    private var knownOperations = [String:Operation]()
    private var lastUsedSymbol =  String()
    var lastUsedOperand = Double?()
    weak var delegate: DisplayTemporaryValueDelegate?
    
    init() {
        knownOperations[kMultiply] = Operation.BinaryOperation(kMultiply){$0 * $1}
        knownOperations[kDivide] = Operation.BinaryOperation(kDivide){$1 / $0}
        knownOperations[kMinus] = Operation.BinaryOperation(kMinus){$1 - $0}
        knownOperations[kPlus] = Operation.BinaryOperation(kPlus){$0 + $1}
        knownOperations[kPercentage] = Operation.UnaryOperation(kPercentage){$0 / 100}
    }
    
    func pushOperand(operand: Double) {
        operationStack.append(operand)
        print(operationStack)
    }
    
    func performOperation(symbol: String) -> Double? {
        if symbol != lastUsedSymbol {
            let result = operate(lastUsedSymbol)
            if let del = delegate {
                del.displayTemporaryValue(result)
            }
        }
        lastUsedOperand = nil
        return operate(symbol)
    }
    
    func performEqualOp(value: Double) -> Double? {
        if lastUsedOperand == nil {
            lastUsedOperand = value
        }
        operationStack.append(lastUsedOperand!)
        return operate(lastUsedSymbol)
    }
    
    func clearStack() {
        lastUsedOperand = nil
        lastUsedSymbol = ""
        operationStack.removeAll(keepCapacity: false)
    }
    
    private func operate(symbol:String) -> Double? {
        if let operation = knownOperations[symbol] {
            lastUsedSymbol = symbol
            switch operation {
            case .UnaryOperation(_, let operation):
                if operationStack.count >= 1 {
                    let result = operation(operationStack.removeLast())
                    pushOperand(result)
                    return result
                }
            case .BinaryOperation(_, let operation):
                if operationStack.count >= 2 {
                    let result = operation(operationStack.removeLast(),operationStack.removeLast())
                    pushOperand(result)
                    return result
                }
            }
        }
        return nil
    }
}
