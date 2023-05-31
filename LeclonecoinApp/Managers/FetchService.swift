//
//  FetchService.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - FetchServiceProtocol

/// The protocol that defines the methods to fetch the articles
protocol FetchServiceProtocol {
    func fetch<T: Decodable>(type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

// The protocol that defines the path of the API request
protocol Endpoint {
    var path: String { get }
}

enum APIEndpoint: Endpoint {
    case articles
    case categories

    var path: String {
        switch self {
        case .articles: return "listing.json"
        case .categories: return "categories.json"
        }
    }
}


/// A class that implements the FetchServiceProtocol and uses APICaller to fetch the data
final class FetchService: FetchServiceProtocol {
    
    // MARK: - Methods
    
    func fetch<T: Decodable>(type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        APICaller.shared.fetchData(type: type, from: endpoint.path, completion: completion)
    }
}
