//
//  BookError.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

enum BookError: Error {
    case statusCode
    case decoding
    case invalidImage
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> BookError {
        return (error as? BookError) ?? .other(error)
    }
}
