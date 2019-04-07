//
//  Operation.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

protocol RevereableOperation {
    func reverse() -> Operation
}

protocol UndoableOperation: CustomStringConvertible {
    func execute(first: Float?, second: Float?)
    func unexecute(first: Float?, second: Float?)
    var result:Float? {get}
}
class Operation:RevereableOperation{
    lazy var operation: UndoableOperation = getOperation(mathOp: mathOp)
    var first:Float?
    var second:Float?
    var mathOp: MathOperator
    var result: Float?
    init(first: Float?, second: Float? = nil, mathOp: MathOperator) {
        self.first = first
        self.second = second
        self.mathOp = mathOp
        self.result = 0
    }
    func execute(){
        operation.execute(first : first, second : second)  // Most operator take one or two parameters
        result = operation.result
    }
    func unExecute(){
        operation.unexecute(first : first, second : second)
        result = operation.result
    }
    func reverse() -> Operation{
        return Operation(first: first, second: second, mathOp: mathOp.inverse)
    }
    
    private func getOperation(mathOp: MathOperator) -> UndoableOperation{
        switch mathOp {
        case .add:
            return AdditionOperation(first: first, second: second)
        case .sub:
            return SubtractionOperation(first: first, second: second)
        case .mul:
            return MultiplyOperation(first: first, second: second)
        case .div:
            return DivisionOperation(first: first, second: second)
        }
    }
    
    var description: String {
        return "\(mathOp.description)\(operation.description)"
    }
}


class AdditionOperation: UndoableOperation,CustomStringConvertible {
    
    var first:Float?
    var second:Float?
    var result: Float?
    
    init(first:Float?, second:Float?) {
        self.first = first
        self.second = second
    }
    
    var description: String { //different for each operation so it needs to be a property for each.
        return "\(second?.getCleanString ?? "")"
    }
    
    func execute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first + second
    }
    
    func unexecute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first - second
    }
}

class SubtractionOperation: UndoableOperation {
    
    var first:Float?
    var second:Float?
    var result: Float?
    
    init(first:Float?, second:Float?) {
        self.first = first
        self.second = second
    }
    
    var description: String { //different for each operation so it needs to be a property for each.
        return "\(second?.getCleanString ?? "")"
    }
    
    func execute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first - second
    }
    
    func unexecute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first + second
    }
}

class MultiplyOperation: UndoableOperation {
    
    var first:Float?
    var second:Float?
    var result: Float?
    
    init(first:Float?, second:Float?) {
        self.first = first
        self.second = second
    }
    
    var description: String { //different for each operation so it needs to be a property for each.
        return "\(second?.getCleanString ?? "")"
    }
    
    func execute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first * second
    }
    
    func unexecute(first: Float?, second: Float?){
        guard let first = first, first != 0, let second = second else {return}
        result = first / second
    }
}

class DivisionOperation: UndoableOperation {
    
    var first:Float?
    var second:Float?
    var result: Float?
    
    init(first:Float?, second:Float?) {
        self.first = first
        self.second = second
    }
    
    var description: String { //different for each operation so it needs to be a property for each.
        return "\(second?.getCleanString ?? "")"
    }
    
    func execute(first: Float?, second: Float?){
        guard let first = first, let second = second, second != 0 else {return}
        result = first / second
    }
    
    func unexecute(first: Float?, second: Float?){
        guard let first = first, let second = second else {return}
        result = first * second
    }
}

extension Float{
    ///Cleans the float value depends on the remainder value.
    var getCleanString:String{
        if (self.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", self)
        }else{
            return String(self)
        }
    }
}
