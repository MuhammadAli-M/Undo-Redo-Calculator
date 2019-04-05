//
//  MathOperation.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

enum MathOperation{
    case add
    case sub
    case mul
    case div
    
    var inverse:MathOperation{
        switch self {
        case .add:  return .sub
        case .sub:  return .add
        case .mul:  return .div
        case .div:  return .mul
        }
    }
    
    private var descriptionDict : [String:MathOperation]{
        return ["+":.add,
                "-":.sub,
                "*":.mul,
                "/":.div]
    }
}

