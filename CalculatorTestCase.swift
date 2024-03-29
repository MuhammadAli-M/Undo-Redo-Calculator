//
//  CalculatorTestCase.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/7/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import XCTest


class CalculatorTestCase: XCTestCase {
    var calculator = Calculator()
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
    
    /// Test series of do ,undo and redo operations.
    /// +3,+2,*5,undo,undo,redo,+3,undo,undo,undo,undo
    func testDoAndUndoAndRedoOperations() {
        let result = SafeFloat(0)
        let op1 = Operation(first: result.get(), second: 3, mathOp: .add)
        calculator.doOperation(operation: op1)
        result.set(calculator.result ?? Float.nan)
        
        let op2 = Operation(first: result.get() , second: 2, mathOp: .add)
        calculator.doOperation(operation: op2)
        result.set(calculator.result ?? Float.nan)
        
        let op3 = Operation(first: result.get() , second: 5, mathOp: .mul)
        calculator.doOperation(operation: op3)
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.redo()
        result.set(calculator.result ?? Float.nan)
        
        let op4 = Operation(first: result.get() , second: 3, mathOp: .add)
        calculator.doOperation(operation: op4)
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        XCTAssertEqual(result.get(), 25)
    }
    
    /// Test series of do ,undo and operations.
    /// +3,+2,*5,undo,undo,+3,undo,undo,undo,undo
    func testDoAndUndoOperations() {
        let result = SafeFloat(0)
        let op1 = Operation(first: result.get(), second: 3, mathOp: .add)
        calculator.doOperation(operation: op1)
        result.set(calculator.result ?? Float.nan)
        
        let op2 = Operation(first: result.get() , second: 2, mathOp: .add)
        calculator.doOperation(operation: op2)
        result.set(calculator.result ?? Float.nan)
        
        let op3 = Operation(first: result.get() , second: 5, mathOp: .mul)
        calculator.doOperation(operation: op3)
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        let op4 = Operation(first: result.get() , second: 3, mathOp: .add)
        calculator.doOperation(operation: op4)
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        calculator.undo()
        result.set(calculator.result ?? Float.nan)
        
        XCTAssertEqual(result.get(), 5)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
