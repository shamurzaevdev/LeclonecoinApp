//
//  File.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - Constants

struct Constants {
    static let baseURL = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
}

enum APIError: Error {
    case failedToGetData
}

/// A Class that fetches the data from needed API
final class APICaller {
    
    // MARK: - Properties
    
    static let shared = APICaller()
    
    // MARK: - API Calls
    
    func fetchData<T: Decodable>(type: T.Type, from urlPath: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(urlPath)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
                
            guard let data = data else {
                completion(.failure(APIError.failedToGetData))
                return
            }
                
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
