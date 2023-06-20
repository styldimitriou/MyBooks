//
//  BookListView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookViewModel: BookViewModel
    
    var body: some View {
        NavigationView {
            List(bookViewModel.books) { book in
                HStack(spacing: 10) {
                    CoverPageView(coverImageURL: book.coverImageURL ?? nil)
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        bookViewModel.toggleFavorite(book: book)
                    }) {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(book.isFavorite ? .red : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle("Books")
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(bookViewModel: BookViewModel())
    }
}
