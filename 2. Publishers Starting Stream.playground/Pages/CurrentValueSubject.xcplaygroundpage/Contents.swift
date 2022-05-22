//: [Previous](@previous)

//Subject - Publisher that you can continously send new values down

//CurrentValueSubject
//used like a var with a Publisher stream attached

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct User {
    var id: Int
    var name: String
}

let currentUserId = CurrentValueSubject<Int, Never>(1000)
let userNames     = CurrentValueSubject<[String], Never>(["Bob", "Susan", "Luise"])
let currentUser   = CurrentValueSubject<User, Never>(User(id: 1, name: "Bob"))



// get the value for currentUserID
print("current user id", currentUserId.value)

// subscribe to Subject
let subscription = currentUserId.sink { completion in
    print("Print completion ", completion)
} receiveValue: { value in
    print("Sink Value: ", value)
}

// passing down new values with Subject
currentUserId.send(1)
currentUserId.send(2)
currentUserId.send(3)

// sending completion finished with Subject
currentUserId.send(completion: .finished)


//: [Next](@next)
