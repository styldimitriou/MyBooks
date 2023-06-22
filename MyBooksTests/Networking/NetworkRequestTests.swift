//
//  NetworkRequestTests.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import XCTest
import Combine
@testable import MyBooks


final class NetworkRequestTests: XCTestCase {
    private var networkRequest: NetworkRequest!
    private var urlSession: URLSessionMock!
    private var request: Request!
    private var response: Publishers.ReceiveOn<AnyPublisher<BookListRaw, NetworkError>, DispatchQueue>?
    private var publisher: AnyCancellable?
    
    struct EndpointMock: Endpoint {
        var baseURL = "https://example.com"
        var path = "/books"
        var parameter: [URLQueryItem]?
    }

    override func setUp() {
        super.setUp()
        let endpoint = EndpointMock()
        request = Request(endpoint: endpoint)
        urlSession = URLSessionMock()
        networkRequest = NetworkRequest(session: urlSession)
    }
    
    override func tearDown() {
        urlSession = nil
        networkRequest = nil
        request = nil
        super.tearDown()
    }
    
    func testRequest_SuccessfulResponse() {
        response = networkRequest.request(request)
            .receive(on: DispatchQueue.main)
        
        
        publisher = response?
            .sink(receiveCompletion: { _ in
                // Failure case
            }, receiveValue: { response in
                XCTAssertEqual(response.count, 70906)
                XCTAssertEqual(response.results.count, 2)
            })
    }
    
    func testRequest_InvalidJSON() {
        urlSession.jsonName = "booksFailed.json"
        
        response = networkRequest.request(request)
            .receive(on: DispatchQueue.main)
        
        publisher = response?.sink(receiveCompletion: { error in
            switch error {
            case .finished: break
            case .failure(let error):
                XCTAssertEqual(error, .invalidJSON(String(describing: error)))
            }
        }, receiveValue: { error in
            XCTFail("failure URLSession: \(error)")
        })
    }
    
    func testRequest_ServerError() {
        urlSession.statusCode = 500
        
        response = networkRequest.request(request)
            .receive(on: DispatchQueue.main)
        
        publisher = response?.sink(receiveCompletion: { error in
            switch error {
            case .finished: break
            case .failure(let error):
                XCTAssertEqual(error, .serverError(code: 0, error: "Server error"))
            }
        }, receiveValue: { error in
            XCTFail("failure URLSession: \(error)")
        })
    }
    
    func testRequest_InvalidURL() {
        struct InvalidEndpoint: Endpoint {
            var baseURL: String
            var path: String
            var parameter: [URLQueryItem]?
        }
        
        let endpoint = InvalidEndpoint(baseURL: "invalid_url", path: "invalid_path")
        let request = Request(endpoint: endpoint)
        response = networkRequest.request(request)
            .receive(on: DispatchQueue.main)
        
        publisher = response?.sink(receiveCompletion: { error in
            switch error {
            case .finished: break
            case .failure(let error):
                XCTAssertEqual(error, .badURL("Invalid Url"))
            }
        }, receiveValue: { error in
            XCTFail("failure URLSession: \(error)")
        })
    }
}
