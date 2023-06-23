//
//  BooksServiceMock.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 23/6/23.
//

import Foundation
import Combine
@testable import MyBooks

class BooksServiceMock: BooksServiceProtocol {
    var bookListPublisher: AnyPublisher<BookListRaw, NetworkError>?

    func fetchBooks() -> AnyPublisher<BookListRaw, NetworkError> {
        return bookListPublisher!
    }

    func fetchMoreBooks(nextPage: String) -> AnyPublisher<BookListRaw, NetworkError> {
        return bookListPublisher!
    }
}
