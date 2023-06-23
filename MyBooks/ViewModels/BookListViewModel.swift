//
//  BookListViewModel.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var subscribers: Set<AnyCancellable> = []
    private var booksService: BooksServiceProtocol
    private var nextPage: String?
    
    init(booksService: BooksServiceProtocol = BooksService()) {
        self.booksService = booksService
    }
    
    func fetchBooks() {
        let bookList = booksService.fetchBooks()
        saveNextPageURL(bookList: bookList)
        saveBookList(bookList: bookList)
    }
    
    func fetchMoreBooks() {
        guard let nextPage = self.nextPage else { return }
        
        let bookList = booksService.fetchMoreBooks(nextPage: nextPage)
        saveNextPageURL(bookList: bookList)
        saveBookList(bookList: bookList)
    }
    
    private func saveNextPageURL(bookList: AnyPublisher<BookListRaw, NetworkError>) {
        bookList
            .sink (receiveCompletion: { _ in }) { booklist in
                self.nextPage = booklist.next
            }
            .store(in: &subscribers)
    }
    
    private func saveBookList(bookList: AnyPublisher<BookListRaw, NetworkError>) {
        bookList
            .map { bookList -> [Book] in
                bookList.results.map({ Book(id: $0.id,
                                            title: $0.title,
                                            author: $0.authors.map({$0.name}).joined(separator: ","),
                                            coverImageURL: $0.formats.imageURL,
                                            languages: $0.languages,
                                            downloadCount: $0.downloadCount)})
            }
            .mapError {
                return BookError.map($0)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] (books: [Book]) in
                self?.books += books
            }
            .store(in: &subscribers)
    }
    
    func toggleFavorite(book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isFavorite.toggle()
        }
    }
}
