//
//  URLSessionMock.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import Foundation
import Combine
@testable import MyBooks

class URLSessionMock: URLSessionProtocol {
    var jsonName = "bookListRaw.json"
    var statusCode = 200
    
    func getPublisher(for url: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        let response = HTTPURLResponse(
            url: url.url!,
            statusCode: statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: nil)!
        
        let file = Bundle(for: type(of: self)).path(forResource: jsonName, ofType: nil) ?? ""
        let url = URL(fileURLWithPath: file)
        
        guard let data = try? Data(contentsOf: url) else {
            return Just((data: Data(), response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
        
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
