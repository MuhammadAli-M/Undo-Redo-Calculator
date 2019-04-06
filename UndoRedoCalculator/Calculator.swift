//
//  Calculator.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

class Calculator {
    
    private var undoStack = Stack<Operation>()
    private var redoStack = Stack<Operation>()
    private var undoCount = 0
    private(set) var result:Float = 0
    
    
    func doOperation( operation: inout Operation) {
        operation.execute()
        undoStack.push(element: operation)
        result = operation.result
        redoStack.clear()
    }
    
    func undo(){
        if canUndo(){
            // TODO: refactor
        undoCount += 1
        if var op = undoStack[undoStack.count - undoCount] {
            undoStack.push(element: op.reverse())
            undoCount += 1
            redoStack.push(element: op)
            op.first = result
            op.unExecute()
            result = op.result
            }
        }else{
            print("No more undo")
        }
    }
    
    func redo(){
        if canRedo(){
        let op = redoStack.pop()
        undoCount = 0   // To start undo from the top of undoStack
        if var op = op {
            undoStack.push(element: op)
            op.first = result
            op.execute()
            result = op.result
        }
        }else{
            print("No more redo")
        }
    }
    
    func canUndo()->Bool{
        return (undoStack.count - undoCount-1) >= 0 ? true:false
    }
    
    func canRedo()->Bool{
        return !redoStack.isEmpty
    }
}


