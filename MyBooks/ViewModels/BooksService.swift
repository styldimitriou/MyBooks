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
    func fetchMoreBooks(nextPage: String) -> AnyPublisher<BookListRaw, NetworkError>
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
    
    func fetchMoreBooks(nextPage: String) -> AnyPublisher<BookListRaw, NetworkError> {
        let queryItems = getURLQueryParams(stringURL: nextPage)
        let endpoint = MyBooksEndpoints.moreBooks(queryItems: queryItems)
        let request = Request(endpoint: endpoint)
        return networkRequest.request(request)
    }
    
    private func getURLQueryParams(stringURL: String) -> [URLQueryItem]? {
        guard let url = URL(string: stringURL) else { return nil }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        return components?.queryItems
    }
}
