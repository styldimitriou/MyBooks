//
//  MyBooksEndpoints.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 21/6/23.
//

import Foundation

enum MyBooksEndpoints: Endpoint {
    case books
    
    var baseURL: String {
        "gutendex.com"
    }
    
    var path: String {
        switch self {
        case .books:
            return "/books"
        }
    }
    
    var parameter: [URLQueryItem] {
        return []
    }
}
