//: [Previous](@previous)

// How to create a subscription?
// What does a publisher without a subscription?
// What does data stream mean?

PlaygroundPage.current.needsIndefiniteExecution = true
import Foundation
import Combine
import PlaygroundSupport

let cancellable: AnyCancellable = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
    .scan(0, { count, val in
        print("val", val)
        return count + 1
    })
    .sink { completion in
        print("Completion : \(completion)")
    } receiveValue: { time in
        print("received value", time)
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    cancellable.cancel()
    // another way is to make subscription optional
//    cancellable = nil
}

//: [Next](@next)
