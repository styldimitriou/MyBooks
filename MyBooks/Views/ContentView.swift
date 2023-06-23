//
//  ContentView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var bookViewModel = BookListViewModel()
    
    var body: some View {
        TabView {
            BookListView(bookViewModel: bookViewModel)
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            FavoriteListView(bookViewModel: bookViewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
