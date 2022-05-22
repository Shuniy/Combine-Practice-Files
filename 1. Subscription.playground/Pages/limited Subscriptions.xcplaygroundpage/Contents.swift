//: [Previous](@previous)

// publishers that will pass a limited number of values

import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let foodbank: Publishers.Sequence<[String], Never> = ["apple","bread","orange","milk"].publisher

let subscription1 = foodbank
    .sink { completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print("Failed with error: ", error)
    }
} receiveValue: { foodItem in
    print(foodItem)
}

let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())
print("End Date", endDate)

struct MyError: Error {
    
}

func throwAtEndDate(foodItem: String, date: Date) throws -> String {
    if date < endDate! {
        return "\(foodItem) at \(date)"
    } else {
        throw MyError()
    }
}

let subscription2 = foodbank.zip(timer)
    .tryMap({ (foodItem, time) in
        try throwAtEndDate(foodItem: foodItem, date: time)
    })
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            print("Failed with error: ", error)
        }
    } receiveValue: { value in
        print("zip tuple value", value)
    }

//: [Next](@next)
