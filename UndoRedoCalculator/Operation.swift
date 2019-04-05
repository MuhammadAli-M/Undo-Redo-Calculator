//
//  Operation.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

struct Operation{
    var first:Int
    var second:Int
    var mathOp: MathOperation
    var result: Int
    init(first:Int, second:Int, mathOp: MathOperation) {
        self.first = first
        self.second = second
        self.mathOp = mathOp
        self.result = 0
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
    
    func evaluate(first:Int, second:Int) -> Int {
        switch mathOp {
        case .add: return first + second
        case .sub: return first - second
        case .mul: return first * second
        case .div: return first / second //TODO: Handle zero-division
        }
    }
}
