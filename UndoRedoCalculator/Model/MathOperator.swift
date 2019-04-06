//
//  MathOperation.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

enum MathOperator{
    case add
    case sub
    case mul
    case div
    
    /// Inverses the operator in a mathmatical way.
    var inverse:MathOperator{
        switch self {
        case .add:  return .sub
        case .sub:  return .add
        case .mul:  return .div
        case .div:  return .mul
        }
    }
    
    private static var descriptionDict : [String:MathOperator]{
        return ["+":.add,
                "-":.sub,
                "*":.mul,
                "/":.div]
    }
    
    /// String description for MathOperator
    var description: String{
        return MathOperator.descriptionDict.getKey(forValue: self) ?? ""
    }
    
    /// Converts a MathOperator from enum to Sting
    /// - Parameters: The operator in a string representation.
    /// - Returns: The corresponding MathOperator.
    static func from(stringOperator: String) -> MathOperator?{
        return MathOperator.descriptionDict[stringOperator]
    }
}

extension Dictionary where Value: Equatable {
    /// Gets The key for specific value of a dictationary
    /// - Parameters: forValue: The target value which it's key is returned.
    /// - Returns: A key for corresponding value.
    func getKey(forValue value: Value) -> Key? {
        return first(where: { $1 == value })?.key
    }
}
