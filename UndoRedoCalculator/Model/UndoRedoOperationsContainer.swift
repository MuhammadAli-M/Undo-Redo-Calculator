//
//  UndoRedoOperationsContainer.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/7/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation


struct UndoRedoOperationsContainer {
    private var undoArray = Array<Operation>()
    private var redoStack = Stack<Operation>()
    
    private var undoCount = 0
    /*
     Undo count increases by successive undo operations.
     If a redo or new operations done, it should be reset.
     It increases by 2, The actual count of successive occured undo operations is (undoCount % 2)
     */
    
    /// Adds an undo operation.
    mutating func AddUndo(operation: Operation){
        undoArray.append(operation)
    }
    
    /// Gets New undo operation.
    mutating func getNewUndoOperation()->Operation?{
        if isUndoAvaialable(){
            let operation = undoArray[undoArray.count - undoCount - 1]
            undoCount += 2
            undoArray.append(operation.reverse())
            redoStack.push(element: operation)
            return operation
        }else{
            return nil
        }
    }
    
    /// Checks if there are undo operations.
    func isUndoAvaialable()->Bool{
        return undoArray.count > undoCount
    }
    
    mutating func resetUndoing() {
        undoCount = 0
    }
    
    
    // MARK: Redo
    
    mutating func AddRedo(operation: Operation){
        redoStack.push(element: operation)
    }
    
    mutating func getNewRedoOperation()->Operation?{
        undoCount = 0
        return isRedoAvaialable() ? redoStack.pop() : nil
    }
    
    func isRedoAvaialable()->Bool{
        return !redoStack.isEmpty
    }
    
    mutating func clearRedoOperations(){
        redoStack.clear()
    }
}
