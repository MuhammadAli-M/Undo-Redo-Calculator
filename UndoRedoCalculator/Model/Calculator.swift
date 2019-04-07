//
//  Calculator.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

protocol CalculatorDelegate:class {
    func operationDidDone(operation: Operation)
    func operationDidUndone(operation: Operation)
    func operationDidRedone(operation: Operation)
}

class Calculator {
    
    private var undoRedoContainer = UndoRedoOperationsContainer()
    
    private(set) var result:Float? = 0
    weak var delegate: CalculatorDelegate?
    
    func doOperation( operation: Operation) {
        operation.execute()
        undoRedoContainer.AddUndo(operation: operation)
        result = operation.result
        undoRedoContainer.clearRedoOperations()
        undoRedoContainer.resetUndoing()
        delegate?.operationDidDone(operation: operation)
    }
    
    /// Undo the last done operation
    func undo(){
        if canUndo(){
            if let operation = undoRedoContainer.getNewUndoOperation(){
            operation.first = result
            operation.unExecute()
            result = operation.result
            delegate?.operationDidUndone(operation: operation)
            }
        }else{
            print("No more undo")
        }
    }
    
    /// Redo the last undone operation
    func redo(){
        if canRedo(){
        let operation = undoRedoContainer.getNewRedoOperation()
        if let operation = operation {
            undoRedoContainer.AddUndo(operation: operation)
            operation.first = result
            operation.execute()
            result = operation.result
            delegate?.operationDidRedone(operation: operation)
        }
        }else{
            print("No more redo")
        }
    }
    
    /// Validates that Redo operation can be done.
    func canUndo()->Bool{
        return undoRedoContainer.isUndoAvaialable()
    }
    
    /// Validates that Redo operation can be done.
    func canRedo()->Bool{
        return undoRedoContainer.isRedoAvaialable()
    }
}


