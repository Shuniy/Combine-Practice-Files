//: [Previous](@previous)

// assign(to:, on:)

// func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable
// ReferenceWritableKeyPath only avaliable for property in class

// enables you to assign the received value to a KVO-compliant property of an object
// upstream publisher's Failure must be Never.

import Foundation
import Combine
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
}

var myObject = MyClass()
let myRange = (0...2)
let pub1 = myRange.publisher
    .map { $0 * 10 }
    .sink { completion in
        print("Completion", completion)
    } receiveValue: { value in
        print("Value", value)
        myObject.anInt = value
    }

let pub2 = myRange.publisher
    .map { $0 * 10 }
    .assign(to: \.anInt, on: myObject)


//: [Next](@next)


