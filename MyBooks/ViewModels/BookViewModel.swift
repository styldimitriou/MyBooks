//
//  BookViewModel.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation
import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var favoriteBooks: [Book] = []
    
    private var subscribers: Set<AnyCancellable> = []
    private var booksService: BooksServiceProtocol
    
    init(booksService: BooksServiceProtocol = BooksService()) {
        self.booksService = booksService
        fetchBooks()
    }
    
    func fetchBooks() {
        booksService
            .fetchBooks()
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
            .sink(receiveCompletion: { _ in }) { [weak self] books in
                self?.books = books
            }
            .store(in: &subscribers)
    }
    
    func toggleFavorite(book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isFavorite.toggle()

            if books[index].isFavorite {
                favoriteBooks.append(books[index])
            } else {
                if let favoriteIndex = favoriteBooks.firstIndex(where: { $0.id == book.id }) {
                    favoriteBooks.remove(at: favoriteIndex)
                }
            }
        }
    }
}
