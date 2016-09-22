//
//  CalculatorOperations.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/16/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import Foundation

let kMultiply = "×"
let kDivide = "÷"
let kPlus = "+"
let kMinus = "−"
let kPercentage = "%"

protocol DisplayTemporaryValueDelegate: class {
    func displayTemporaryValue(_ value: Double?)
}

class CalculatorOperations
{
    fileprivate enum Operation: CustomStringConvertible {
        case unaryOperation(String, (Double) -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .unaryOperation(let symbol, _):
                    return symbol
                case .binaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    fileprivate var operationStack = [Double]()
    fileprivate var knownOperations = [String:Operation]()
    fileprivate var lastUsedSymbol =  String()
    var lastUsedOperand = Double?()
    weak var delegate: DisplayTemporaryValueDelegate?
    
    init() {
        knownOperations[kMultiply] = Operation.binaryOperation(kMultiply){$0 * $1}
        knownOperations[kDivide] = Operation.binaryOperation(kDivide){$1 / $0}
        knownOperations[kMinus] = Operation.binaryOperation(kMinus){$1 - $0}
        knownOperations[kPlus] = Operation.binaryOperation(kPlus){$0 + $1}
        knownOperations[kPercentage] = Operation.unaryOperation(kPercentage){$0 / 100}
    }
    
    func pushOperand(_ operand: Double) {
        operationStack.append(operand)
        print(operationStack)
    }
    
    func performOperation(_ symbol: String) -> Double? {
        if symbol != lastUsedSymbol {
            let result = operate(lastUsedSymbol)
            if let del = delegate {
                del.displayTemporaryValue(result)
            }
        }
        lastUsedOperand = nil
        return operate(symbol)
    }
    
    func performEqualOp(_ value: Double) -> Double? {
        if lastUsedOperand == nil {
            lastUsedOperand = value
        }
        operationStack.append(lastUsedOperand!)
        return operate(lastUsedSymbol)
    }
    
    func clearStack() {
        lastUsedOperand = nil
        lastUsedSymbol = ""
        operationStack.removeAll(keepingCapacity: false)
    }
    
    fileprivate func operate(_ symbol:String) -> Double? {
        if let operation = knownOperations[symbol] {
            lastUsedSymbol = symbol
            switch operation {
            case .unaryOperation(_, let operation):
                if operationStack.count >= 1 {
                    let result = operation(operationStack.removeLast())
                    pushOperand(result)
                    return result
                }
            case .binaryOperation(_, let operation):
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

