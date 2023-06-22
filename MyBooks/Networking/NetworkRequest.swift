//
//  NetworkRequest.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import Foundation
import Combine

protocol Requestable {
    func request<T: Decodable>(_ req: Request) -> AnyPublisher<T, NetworkError>
}

class NetworkRequest: Requestable {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request<T>(_ req: Request) -> AnyPublisher<T, NetworkError>
    where T: Decodable {
        
        guard let url = req.getURLRequest() else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        
        return session.getPublisher(for: url)
            .tryMap { output in
                // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
