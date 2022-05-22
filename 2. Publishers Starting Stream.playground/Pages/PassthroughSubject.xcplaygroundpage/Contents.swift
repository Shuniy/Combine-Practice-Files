import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//Subject - Publisher that you can continously send new values down

// PassthroughSubject
// use for starting action/process, equivalent to func

let newUserNameEntered = PassthroughSubject<String, Never>()


// get the value for newUserNameEntered
// does not hold any value

// subscribe to Subject
let subscription = newUserNameEntered
    .subscribe(on: DispatchQueue.global(qos: .background))
    .sink { completion in
        print("is main thread", Thread.isMainThread)
        print("Completion: ", completion)
    } receiveValue: { value in
        print("Sink value: ", value)
    }

// passing down new values with Subject
newUserNameEntered.send("Shubham")
newUserNameEntered.send("Kumar")

// sending completion finished with Subject
newUserNameEntered.send(completion: .finished)
