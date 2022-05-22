//: [Previous](@previous)

//Example for CurrentValueSubject and PassthroughSubject
//PassthroughSubject: use for starting action/process, equivalent to func


import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewModel {
    
    private let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill"])
    var userNames: AnyPublisher<[String], Never>
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // create publisher stream that updates userNames whenever a newUserNameEntered has a new value
        userNames = userNamesSubject.eraseToAnyPublisher()
        
        newUserNameEntered.sink { completion in
            print("Completion", completion)
        } receiveValue: { [unowned self] username in
            self.userNamesSubject.send(userNamesSubject.value + [username])
        }.store(in: &subscriptions)
        
        userNames.sink { users in
            print("UserNames changed to: ", users)
        }

    }
}

let viewModel = ViewModel()
 
// add new user name "Susan"
viewModel.newUserNameEntered.send("Susan")

// add new user name "Bob"
viewModel.newUserNameEntered.send("Bob")

// who do you protect userName from not setting it directly
viewModel.newUserNameEntered.send("Hello")
viewModel.userNames.sink { value in
    print("Values in AnyPublisher: ", value)
}

//: [Next](@next)
