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
            List(bookViewModel.books.indices, id: \.self) { index in
                let book = bookViewModel.books[index]
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
                .onAppear {
                    // Load more books when reaching the end of the list
                    if book.id == bookViewModel.books.last?.id {
                        bookViewModel.fetchMoreBooks()
                    }
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
