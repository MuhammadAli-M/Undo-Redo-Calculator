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
    
    private var undoStack = Stack<Operation>()
    private var redoStack = Stack<Operation>()
    private var undoCount = 0
    private(set) var result:Float? = 0
    weak var delegate: CalculatorDelegate?
    
    func doOperation( operation: Operation) {
        operation.execute()
        undoStack.push(element: operation)
        result = operation.result
        redoStack.clear()
        delegate?.operationDidDone(operation: operation)
    }
    
    /// Undo the last done operation
    func undo(){
        if canUndo(){
            // TODO: refactor
        undoCount += 1
        if var operation = undoStack[undoStack.count - undoCount] { // To go back with number of undos
            undoStack.push(element: operation.reverse())
            undoCount += 1          // To consider pushing this undo operation in the undo stack
            redoStack.push(element: operation)
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
        let operation = redoStack.pop()
        undoCount = 0   // To start undo from the top of undoStack
        if var operation = operation {
            undoStack.push(element: operation)
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
        return (undoStack.count - undoCount-1) >= 0 ? true:false
    }
    
    /// Validates that Redo operation can be done.
    func canRedo()->Bool{
        return !redoStack.isEmpty
    }
}


