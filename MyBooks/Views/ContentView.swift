//
//  ContentView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookListView(books: [])
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            FavoriteListView(favoriteBooks: [])
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .onAppear {
            #warning("Fetch books from API")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
