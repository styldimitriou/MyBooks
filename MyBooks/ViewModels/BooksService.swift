//
//  BooksService.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 21/6/23.
//

import Foundation
import Combine

protocol BooksServiceProtocol {
    func fetchBooks() -> AnyPublisher<BookListRaw, NetworkError>
}

class BooksService: BooksServiceProtocol {
    private var networkRequest: Requestable
    
    init(networkRequest: Requestable = NetworkRequest()) {
        self.networkRequest = networkRequest
    }
    
    func fetchBooks() -> AnyPublisher<BookListRaw, NetworkError> {
        let endpoint = MyBooksEndpoints.books
        let request = Request(endpoint: endpoint)
        return networkRequest.request(request)
    }
}
