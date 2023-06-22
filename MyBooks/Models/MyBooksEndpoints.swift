//
//  MyBooksEndpoints.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 21/6/23.
//

import Foundation

enum MyBooksEndpoints: Endpoint {
    case books
    case moreBooks(queryItems: [URLQueryItem]?)
    
    var baseURL: String {
        "gutendex.com"
    }
    
    var path: String {
        switch self {
        case .books, .moreBooks(_):
            return "/books"
        }
    }
    
    var parameter: [URLQueryItem]? {
        switch self {
        case .books:
            return nil
        case .moreBooks(let queryItems):
            return queryItems
        }
    }
}
