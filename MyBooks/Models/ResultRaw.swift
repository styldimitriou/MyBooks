//
//  ResultRaw.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation

struct ResultRaw: Decodable {
    let id: Int
    let title: String
    let authors: [PersonRaw]
    let languages: [String]
    let formats: Formats
    let downloadCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case languages
        case formats
        case downloadCount = "download_count"
    }
}

extension ResultRaw {
    struct Formats: Decodable {
        let imageURL: URL
        
        enum CodingKeys: String, CodingKey {
            case imageURL = "image/jpeg"
        }
    }
}

extension ResultRaw {
    struct PersonRaw: Decodable {
        let name: String
    }
}
