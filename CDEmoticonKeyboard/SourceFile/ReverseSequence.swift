//
//  ReverseSequence.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/17.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import Foundation

///先定义一个实现了IteratorProtocol协议的类型
///IteratorProtocol需要指定一个typealias Element
///以及提供一个返回Element?的方法next()
class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var array : [Element]
    
    var currentIndex = 0
    
    init(array : [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}
///Sequence和IteratorProtocol很相似
///不过换成了指定一个typealias Iterator
///以及提供一个返回Iterator?的方法makeIterator()
struct ReverseSequence<T>: Sequence {
    var array : [T]
    
    init(array : [T]) {
        self.array = array
    }
    
    typealias Iterator = ReverseIterator<T>
    
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
    
}
