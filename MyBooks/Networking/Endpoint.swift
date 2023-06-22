//
//  Endpoint.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String {get}
    var parameter: [URLQueryItem]? { get }
    // Additional properties can be added in the future (i.e headers, method etc)
    
    func getURL() -> URL?
}

extension Endpoint {
    func getURL() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        component.queryItems = parameter
        return component.url
    }
}
