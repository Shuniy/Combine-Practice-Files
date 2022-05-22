//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// dataTaskPublisher always remains in other thread
// and wont change its thread even when subscribe is mentioned

let subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com")!)
   .map({ result in
       print(Thread.current.isMainThread)
  })
   .subscribe(on: DispatchQueue.main)
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { _ in }, receiveValue: { value in
        print(Thread.current.isMainThread)
    })


//: [Next](@next)
