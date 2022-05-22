//: [Previous](@previous)

/*
 @Published property wrapper
 adds a Publisher to a property

- use `@Published` for class propeties not structures.
 
 */


import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewModel {
    
    // use @Published to create publisher
//    let userNames = CurrentValueSubject<[String], Never>(["Bill"])
    @Published var userNames: [String] = ["Bill"]
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $userNames.sink { completion in
            print("Completion : ", completion)
        } receiveValue: { value in
            print("value : ", value)
        }.store(in: &subscriptions)
        
        newUserNameEntered.sink { [unowned self] value in
            self.userNames.append(value)
        }.store(in: &subscriptions)

        
    }
}

let viewModel = ViewModel()

// add new user name "Susan"
viewModel.newUserNameEntered.send("Shubham")
viewModel.newUserNameEntered.send("Kumar")

// add new user name "Bob"
viewModel.newUserNameEntered.send("Bob")

//  Documentation: When the property changes, publishing occurs in the property's `willSet` block, meaning subscribers receive the new value before it's actually set on the property.




//: [Next](@next)
