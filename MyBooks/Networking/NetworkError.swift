//
//  NetworkError.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case invalidJSON(_ error: String)
    case serverError(code: Int, error: String)
    case unknown(code: Int, error: String)
}
