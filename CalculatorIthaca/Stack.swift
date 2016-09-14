//
//  Stack.swift
//  CalculatorIthaca
//
//  Created by Haofei Ying on 9/13/16.
//  Copyright © 2016 Haofei Ying. All rights reserved.
//

import Foundation

class Stack<T> {
    
    var data: Array<T> = []
    
    func push(x: T) {
        self.data.append(x)
    }
    
    func peek() -> T {
        return self.data.last!
    }
    
    func pop() -> T {
        let ret: T = self.data.last!
        self.data.removeLast()
        return ret
    }
    
    func isEmpty() -> Bool {
        return self.data.count == 0
    }
    
    func clear() {
        self.data.removeAll()
    }
}
