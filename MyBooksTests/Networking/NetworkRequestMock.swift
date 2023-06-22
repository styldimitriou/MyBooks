//
//  NetworkRequestMock.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import Foundation
import Combine
@testable import MyBooks

class NetworkRequestMock: Requestable {
    var responseMock: AnyPublisher<BookListRaw, NetworkError>!

    func request<T>(_ req: Request) -> AnyPublisher<T, NetworkError> where T : Decodable {
        if let booksResponse = responseMock as? AnyPublisher<T, NetworkError> {
            return booksResponse
        }

        fatalError("Missing booksResponse in NetworkRequestMock")
    }
}
