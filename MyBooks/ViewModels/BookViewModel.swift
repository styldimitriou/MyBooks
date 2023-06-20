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
        
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        let mockBooks = [
            Book(id: 1, title: "Book 1", author: "Author 1", coverImageURL: URL(string: "https://example.com/cover1.jpg")!, languages: [], downloadCount: 1),
            Book(id: 2, title: "Book 2", author: "Author 2", coverImageURL: URL(string: "https://example.com/cover2.jpg")!, languages: [], downloadCount: 1),
            Book(id: 3, title: "Book 3", author: "Author 3", coverImageURL: URL(string: "https://example.com/cover3.jpg")!, languages: [], downloadCount: 1)
        ]
        
        books = mockBooks
    }
    
    func toggleFavorite(book: Book) {
        // TODO
    }
}
