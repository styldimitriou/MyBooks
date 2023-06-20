//
//  FavoriteListView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct FavoriteListView: View {
    var favoriteBooks: [Book]
    
    var body: some View {
        NavigationView {
            List(favoriteBooks) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(favoriteBooks: [])
    }
}
