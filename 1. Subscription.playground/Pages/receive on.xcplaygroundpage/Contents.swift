//: [Previous](@previous)

// multithreading
// where and how to change threads?


import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .map { $0 } // doing something expensive operation
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { value in
        print("receive value \(value)")
        print(Thread.current)
    })

intSubject.send(1)

// Sets the downstream of data, that is where to receive or sink data from

DispatchQueue.global().async {
  intSubject.send(2)
}

//: [Next](@next)
