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
    var description: String{
        return MathOperator.descriptionDict.getKey(forValue: self) ?? ""
    }
    
    static func operationForString(stringOperator: String) -> MathOperator?{
        return MathOperator.descriptionDict[stringOperator]
    }
}

extension Dictionary where Value: Equatable {
    func getKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
