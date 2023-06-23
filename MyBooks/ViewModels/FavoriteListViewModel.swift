//
//  FavoriteListViewModel.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 23/6/23.
//

import Foundation
import Combine

class FavoriteListViewModel: ObservableObject {
    @Published var favoriteBooks: [Book] = []

    func updateFavoriteBooks(from books: [Book]) {
        favoriteBooks = books.filter { $0.isFavorite }
    }
}
