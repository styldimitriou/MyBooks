//
//  BookListView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var viewModel: BookListViewModel
    @ObservedObject var favoriteListViewModel: FavoriteListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.books.indices, id: \.self) { index in
                let book = viewModel.books[index]
                HStack(spacing: 10) {
                    CoverPageView(imageURL: book.coverImageURL, size: .cover)
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite(book: book)
                        favoriteListViewModel.updateFavoriteBooks(from: viewModel.books)
                    }) {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(book.isFavorite ? .red : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .onAppear {
                    // Load more books when reaching the end of the list
                    if book.id == viewModel.books.last?.id {
                        viewModel.fetchMoreBooks()
                    }
                }
            }
            .navigationBarTitle("Books")
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        #warning("Should use mocked data here to avoid network call")
        BookListView(viewModel: BookListViewModel(),
                     favoriteListViewModel: FavoriteListViewModel())
    }
}
