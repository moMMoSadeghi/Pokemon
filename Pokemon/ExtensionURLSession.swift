//
//  ApiService.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import Foundation




extension URLSession {
    
    
    func request<T: Codable> (url: URL?, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        guard let correctURL = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        let task = dataTask(with: correctURL) { data, _, error in
            guard let receivedData = data else {
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(expecting, from: receivedData)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
