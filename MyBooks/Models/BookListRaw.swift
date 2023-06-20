//
//  BookListRaw.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

struct BookListRaw: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ResultRaw]
}
