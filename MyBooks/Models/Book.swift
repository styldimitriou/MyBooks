//
//  Book.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

struct Book: Identifiable, Decodable {
    let id: Int
    let title: String
    let author: String
    let coverImageURL: URL?
    var isFavorite: Bool = false
    let languages: String
    let downloadCount: Int
}
