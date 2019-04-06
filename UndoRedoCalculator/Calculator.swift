//
//  Calculator.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

class Calculator {
    
    var undoStack = Stack<Operation>()
    var redoStack = Stack<Operation>()
    var undoCount = 0
    var result = 0
    
    
    func doOperation( operation: inout Operation) {
        operation.execute()
        undoStack.push(element: operation)
        result = operation.result
        redoStack.clear()
    }
    
    func undo(){
        undoCount += 1
        if var op = undoStack[undoStack.count - undoCount] {
            undoStack.push(element: op.reverse())
            undoCount += 1
            redoStack.push(element: op)
            op.first = result
            op.unExecute()
            result = op.result
        }
    }
    
    func redo(){
        let op = redoStack.pop()
        undoCount = 0   // To start undo from the top of undoStack
        if var op = op {
            undoStack.push(element: op)
            op.first = result
            op.execute()
            result = op.result
        }
    }
}


// MARK: Stack

struct Stack<T> {
    private var list:[T] = []
    
    mutating func push(element: T){
        list.append(element)
    }
    
    mutating func pop() -> T?{
        if list.isEmpty {
            return nil
        }else{
            return list.removeLast()
        }
    }
    
    mutating func peek() -> T?{
        return list.last
    }
    
    mutating func clear(){
        return list.removeAll()
    }
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var count: Int {
        return list.count
    }
    
    subscript(_ index:Int) -> T?{
        if (index >= 0 && index < list.count){
            return list[index]
        }else{
            return nil
        }
    }
}
