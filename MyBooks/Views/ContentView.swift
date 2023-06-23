//
//  ContentView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var bookListViewModel = BookListViewModel()
    @ObservedObject private var favoriteListViewModel = FavoriteListViewModel()
    
    var body: some View {
        TabView {
            BookListView(viewModel: bookListViewModel, favoriteListViewModel: favoriteListViewModel)
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            FavoriteListView(viewModel: favoriteListViewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .onAppear() {
            bookListViewModel.fetchBooks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
