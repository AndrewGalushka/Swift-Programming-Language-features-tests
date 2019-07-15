//: Playground - noun: a place where people can play

import UIKit

enum NetworkError: Error, LocalizedError, CaseIterable {
    case networkError___noInternetConnection
    case networkError___badRequest
    
    var errorDescription: String? {
        
        switch self {
        case .networkError___noInternetConnection:
            return "No Internet Connection"
        case .networkError___badRequest:
            return "Bad Reqest"
        }
    }
    
    var recoverySuggestion: String? {
        
        switch self {
        case .networkError___noInternetConnection:
            return "Connect to network and try again"
        case .networkError___badRequest:
            return "Server unable to process Request due to invalid syntax"
        }
    }
}

enum ParsingError: Error, LocalizedError, CaseIterable {
    case parsingError___invalidValue
    case parsingError___castFailure
}

enum InternalError: Error, LocalizedError, CaseIterable {
    case internalError___1
    case internalError___2
}

extension Optional where Wrapped: Error {
    
    func throwErrorIfNotNil() throws {
        
        if case .some(let error) = self {
            throw error
        }
    }
}

enum CustomError: Error {
    case noInternetConnection
    
    var localizedDescription: String {
        
        switch self {
        case .noInternetConnection:
            return "no internet connection"
        }
    }
}

func someThrowingFunction() throws {
    
    switch Int.random(in: 0...2) {
    case 0:
         try NetworkError.allCases.randomElement().throwErrorIfNotNil()
    case 1:
        try ParsingError.allCases.randomElement().throwErrorIfNotNil()
    case 2:
        try InternalError.allCases.randomElement().throwErrorIfNotNil()
    default:
        break
    }
}

func main() {
    let description = CustomError.noInternetConnection.localizedDescription
    print(description)
}


main()
