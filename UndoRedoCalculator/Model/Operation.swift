//
//  Operation.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

struct Operation:CustomStringConvertible{
    var first:Float
    var second:Float
    var mathOp: MathOperator
    var result: Float
    init(first:Float, second:Float, mathOp: MathOperator) {
        self.first = first
        self.second = second
        self.mathOp = mathOp
        self.result = 0
    }
    
    var description: String {
        return "\(mathOp.description)\(second.getCleanString)"
    }
    
    mutating func execute(){
        result = evaluate(first: first, second: second)
    }
    
    mutating func unExecute(){
        self.mathOp = mathOp.inverse
        result = evaluate(first: first, second: second)
    }
    
    func reverse() -> Operation{
        var op = self
        op.mathOp = self.mathOp.inverse
        return op
    }
    
    func evaluate(first:Float, second:Float) -> Float {
        switch mathOp {
            //TODO: Handle zero-division and results out of valid range
        case .add: return first + second
        case .sub: return first - second
        case .mul: return first * second
        case .div: return first / second
        }
    }
}

extension Float{
    var getCleanString:String{
        if (self.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", self)
        }else{
            return String(self)
        }
    }
}
