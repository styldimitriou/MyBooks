//
//  URLSessionProtocol.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 22/6/23.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    typealias PublisherOutput = URLSession.DataTaskPublisher.Output
    func getPublisher(for url: URLRequest) -> AnyPublisher<PublisherOutput, URLError>
}

extension URLSession: URLSessionProtocol {
    func getPublisher(for url: URLRequest) -> AnyPublisher<PublisherOutput, URLError> {
            dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
