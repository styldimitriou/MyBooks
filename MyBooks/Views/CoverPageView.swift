//
//  CoverPageView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct CoverPageView: View {
    var coverImageURL: URL?
    
    var body: some View {
        AsyncImage(url: coverImageURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
            } else if phase.error != nil {
                Image(systemName: "book")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
            } else {
                ProgressView()
            }
        }
    }
}
