//
//  Request.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

struct Request {
    let endpoint: Endpoint
    // Additional properties can be added in the future (i.e body, timeout etc)
    
    public init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func getURLRequest() -> URLRequest? {
        guard let url = endpoint.getURL() else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
