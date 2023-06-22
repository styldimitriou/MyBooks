//
//  RequestTests.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import XCTest
@testable import MyBooks

final class RequestTests: XCTestCase {
    
    func testGetURLRequestWithValidEndpoint() {
        // Given
        struct ValidEndpoint: Endpoint {
            var baseURL: String {
                "example.com"
            }
            var path: String {
                "/test"
            }
            var parameter: [URLQueryItem]?
        }
        
        let endpoint = ValidEndpoint()
        let request = Request(endpoint: endpoint)
        
        // When
        let urlRequest = request.getURLRequest()
        
        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://example.com/test")
    }
    
    func testGetURLRequestWithInvalidEndpoint() {
        // Given
        struct InvalidEndpoint: Endpoint {
            var baseURL: String
            var path: String
            var parameter: [URLQueryItem]?
        }
        
        let endpoint = InvalidEndpoint(baseURL: "invalid_url", path: "invalid_path")
        let request = Request(endpoint: endpoint)
        
        // When
        let urlRequest = request.getURLRequest()
        
        // Then
        XCTAssertNil(urlRequest)
    }
}
