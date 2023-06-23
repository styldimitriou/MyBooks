//
//  FavoriteListViewModelTests.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 23/6/23.
//

import XCTest
@testable import MyBooks

final class FavoriteListViewModelTests: XCTestCase {
    func testUpdateFavoriteBooks_ListContainsFavorite() {
        // Given
        let favoriteBook = Book(id: 1,
                                title: "Book 1",
                                author: "Author 1",
                                coverImageURL: URL(string:"https://example.com/book1.jpg")!,
                                isFavorite: true,
                                languages: "English",
                                downloadCount: 100)
        let books = [favoriteBook]
        let viewModel = FavoriteListViewModel()
        
        // When
        viewModel.updateFavoriteBooks(from: books)
        
        // Then
        XCTAssertFalse(viewModel.favoriteBooks.isEmpty)
        XCTAssertEqual(viewModel.favoriteBooks[0].id, books[0].id)
    }
    
    func testUpdateFavoriteBooks_NoFavorite() {
        // Given
        let book = Book(id: 1,
                        title: "Book 1",
                        author: "Author 1",
                        coverImageURL: URL(string:"https://example.com/book1.jpg")!,
                        languages: "English",
                        downloadCount: 100)
        let viewModel = FavoriteListViewModel()
        
        // When
        viewModel.updateFavoriteBooks(from: [book])
        
        // Then
        XCTAssertTrue(viewModel.favoriteBooks.isEmpty)
    }
}
