//: [Previous](@previous)

// Important note
// assign(to, on: self) -> memory cycle

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct User: Identifiable {
    let name: String
    let id: Int
}

class ViewModel {
    
    var user = CurrentValueSubject<User, Never>(User(name: "Bob", id: 1))
    var userID: Int = 1 {
        didSet {
            print("userId changed to \(userID)")
        }
    }

    var subscriptions = Set<AnyCancellable>()
    
    init() {
        user.map(\.id)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [unowned self] value in
                self.userID = value
            })
//            .assign(to: \.userID, on: self)
            .store(in: &subscriptions)
    }
    
    deinit {
        print("deinit")
    }
}

var viewModel: ViewModel? = ViewModel()
viewModel?.user.send(User(name: "Shubham", id: 2))

viewModel = nil

//: [Next](@next)
