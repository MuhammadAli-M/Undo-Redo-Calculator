//
//  SafeFloat.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

protocol SafeFloatDelegate: class {
    func safeFloatValueDidSet()
}

/// A Class of float that can be set and get in a thread-safe way.
class SafeFloat {
    private let queue = DispatchQueue(label: "MA.UndoRedoCalculator.SafeFloat", attributes: .concurrent)
    private var value:Float
    weak var delegate: SafeFloatDelegate?
    
    /// Safely set a float
    /// - Parameters: value: The Value needed to be set.
    func set(_ value:Float){
        queue.async(flags: .barrier) {
            self.value = value
        }
        delegate?.safeFloatValueDidSet()
    }
    
    /// Gets the float value in a thread-safe way.
    /// - Returns: The float value.
    func get() -> Float{
        var result = Float()
        queue.sync{
            result = value
        }
        return result
    }
    
    init() {
        value = Float()
    }
    
    convenience init(_ value:Float) {
        self.init()
        set(value)
    }

}
