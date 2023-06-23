//
//  BookListViewModelTests.swift
//  MyBooksTests
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import XCTest
import Combine
@testable import MyBooks

class BookListViewModelTests: XCTestCase {
    var viewModel: BookListViewModel!
    var booksService: BooksServiceMock!
    var subscribers: Set<AnyCancellable>!
    
    struct MockData {
        static let book = Book(id: 1,
                               title: "Book 1",
                               author: "Author 1",
                               coverImageURL: URL(string:"https://example.com/book1.jpg")!,
                               languages: ["English"],
                               downloadCount: 100)
    }
    
    override func setUp() {
        super.setUp()
        booksService = BooksServiceMock()
        viewModel = BookListViewModel(booksService: booksService)
        subscribers = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        subscribers = nil
        viewModel = nil
        booksService = nil
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
    
    func testFetchBooks() {
        // Given
        guard let bookList = loadJson(filename: "bookListRaw") else {
            XCTFail("Could not read from file")
            return
        }
        
        booksService.bookListPublisher = Just(bookList)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        // When
        viewModel.fetchBooks()
        
        // Then
        XCTAssertEqual(viewModel.books.count, bookList.results.count)
        XCTAssertEqual(viewModel.books.first?.title, bookList.results.first?.title)
        XCTAssertEqual(viewModel.books.first?.author, bookList.results.first?.authors.map({ $0.name }).joined(separator: ","))
        XCTAssertEqual(viewModel.books.first?.coverImageURL, bookList.results.first?.formats.imageURL)
    }
    
    func testFetchMoreBooks() {
        // Given
        guard let bookList = loadJson(filename: "bookListRaw") else {
            XCTFail("Could not read from file")
            return
        }
        
        booksService.bookListPublisher = Just(bookList)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        // When
        viewModel.fetchMoreBooks()
        
        // Then
        XCTAssertEqual(viewModel.books.count, bookList.results.count)
        XCTAssertEqual(viewModel.books.first?.title, bookList.results.first?.title)
        XCTAssertEqual(viewModel.books.first?.author, bookList.results.first?.authors.map({ $0.name }).joined(separator: ","))
        XCTAssertEqual(viewModel.books.first?.coverImageURL, bookList.results.first?.formats.imageURL)
    }
    
    func testToggleFavorite_BookIsNotFavorite() {
        // Given
        let book = MockData.book
        viewModel.books = [book]
        
        // When
        viewModel.toggleFavorite(book: book)
        
        // Then
        XCTAssertTrue(viewModel.books[0].isFavorite)
//        XCTAssertTrue(viewModel.favoriteBooks.contains(where: book))
    }
    
    func testToggleFavorite_BookIsFavorite() {
        // Given
        var book = MockData.book
        book.isFavorite = true
        viewModel.books = [book]
        viewModel.favoriteBooks = [book]
        
        // When
        viewModel.toggleFavorite(book: book)
        
        // Then
        XCTAssertFalse(viewModel.books[0].isFavorite)
//        XCTAssertFalse(viewModel.favoriteBooks.contains(where: book))
    }
}
