//: [Previous](@previous)

// subscribe on
// change the thread upstream to the publisher

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellables = Set<AnyCancellable>()
let intSubject = PassthroughSubject<Int, Never>()

// Subscribe sets the upstream of data, means on which thread data should be sent
// sink always work in main thread, unless changed with receive

intSubject
    .subscribe(on: DispatchQueue.global())
  .sink(receiveValue: { value in
    print(value)
    print(Thread.current)
  }).store(in: &cancellables)

intSubject.send(1)
intSubject.send(2)
intSubject.send(3)



//: [Next](@next)
