//
//  BookServiceTests.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import XCTest

import XCTest
import Combine
@testable import MyBooks

class BooksServiceTests: XCTestCase {
    var booksService: BooksService!
    var networkRequest: NetworkRequestMock!

    override func setUp() {
        super.setUp()
        networkRequest = NetworkRequestMock()
        booksService = BooksService(networkRequest: networkRequest)
    }

    override func tearDown() {
        booksService = nil
        networkRequest = nil
        super.tearDown()
    }
    
    private func loadJson(filename fileName: String) -> BookListRaw? {
        if let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(BookListRaw.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    func testFetchBooks_SuccessfulResponse() {
        // Given
        guard let expectedResponse = loadJson(filename: "bookListRaw") else {
            XCTFail("Could not read from file")
            return
        }
        
        networkRequest.responseMock = Just(expectedResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // When
        let expectation = XCTestExpectation(description: "Fetch books completion")
        let cancellable = booksService.fetchBooks()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Fetch books should not fail: \(error)")
                    }
                    expectation.fulfill()
                },
                receiveValue: { response in
                    // Then
                    XCTAssertNotNil(response)
                    XCTAssertEqual(response.results.count, expectedResponse.results.count, "Received response should match expected response")
                }
            )

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }

    func testFetchMoreBooks_SuccessfulResponse() {
        // Given
        guard let expectedResponse = loadJson(filename: "bookListRaw") else {
            XCTFail("Could not read from file")
            return
        }
        
        networkRequest.responseMock = Just(expectedResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()


        let nextPage = "https://example.com/books?page=2"

        // When
        let expectation = XCTestExpectation(description: "Fetch more books completion")
        let cancellable = booksService.fetchMoreBooks(nextPage: nextPage)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        XCTFail("Fetch more books should not fail: \(error)")
                    }
                    expectation.fulfill()
                },
                receiveValue: { response in
                    // Then
                    XCTAssertNotNil(response)
                    XCTAssertEqual(response.results.count, expectedResponse.results.count, "Received response should match expected response")
                }
            )

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
}
