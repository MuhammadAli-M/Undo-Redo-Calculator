//
//  Stack.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import Foundation

struct Stack<T> {
    private var list = SafeArray<T>()
    
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
        return list[index]
    }
}
