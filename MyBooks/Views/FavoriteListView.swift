//
//  FavoriteListView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: FavoriteListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteBooks) { book in
                HStack(spacing: 10) {
                    CoverPageView(imageURL: book.coverImageURL, size: .thumbnail)
                    VStack(alignment: .leading) {
                        Text(book.title + " (\(book.languages))")
                            .font(.headline)
                        Text("by " + book.author)
                            .font(.subheadline)
                        Spacer()
                            .frame(height: 6)
                        Text("\(String(describing: book.downloadCount.dotFormatted())) downloads")
                            .font(.caption2)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(viewModel: FavoriteListViewModel())
    }
}
