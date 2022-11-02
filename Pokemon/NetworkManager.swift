//
//  NetworkManager.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import Foundation



class NetworkManager {
    
    private let session: URLSession
    
    init(){
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        session = URLSession(configuration: config)
    }
    
    /// fetching data from server and decode it
    /// - Parameters:
    ///   - urlName: this name must be String
    ///   - method: HTTPMethod, the defualt value for this property is .get
    ///   - headers: use it when the request needs header
    ///   - type: to decleare at the end of decoding what type of object we must have
    ///   - completionHandler: Result<T,Error>
    func fetchDataFromServer<T: Codable>(urlName: String, method: HTTPMethod = .get, headers: [String : String]? = nil, type: T.Type, completionHandler: @escaping (Result<T, NetworkingError>) -> Void){
        guard let url = URL(string: urlName) else {
            return completionHandler(.failure(NetworkingError.badUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        session.dataTask(with: urlRequest) {(data, response, error) in
            if let error = error {
                return completionHandler(.failure(.badResponse(errorMessage: error.localizedDescription)))
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completionHandler(.failure(.badStatusCode))
            }
            guard let data = data else {
                return completionHandler(.failure(.badData))
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(object))
            } catch {
                completionHandler(.failure(.badData))
            }
        }
        .resume()
    }
    
    
//    func fetchDataFromServer<T: Codable>(urlName: String, type: T.Type) -> AnyPublisher<T, Error> {
//        guard let url = URL(string: urlName) else {
//            return Fail(error: NetworkingError.badUrl).eraseToAnyPublisher()
//        }
//        return session.dataTaskPublisher(for: url)
//              .map(\.data)
//              .decode(type: T.self, decoder: JSONDecoder())
//              .eraseToAnyPublisher()
//    }
    
}

extension NetworkManager {

//    func fetchDataFromServer(urlName: String) -> AnyPublisher<Data, Error>{
//        guard let url = URL(string: urlName) else {
//            return Fail(error: NetworkingError.badUrl).eraseToAnyPublisher()
//        }
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap({ output in
//                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 &&  response.statusCode < 300 else {
//                    throw NetworkingError.badResponse(errorMessage: TextsDescription.NetworkingErrorsDescription.badResponse)
//                }
//                return output.data
//            })
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//    
//    func handleUrlResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
//        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 &&  response.statusCode < 300 else {
//            throw NetworkingError.badResponse(errorMessage: TextsDescription.NetworkingErrorsDescription.badResponse)
//        }
//        return output.data
//    }
//    
//    func handleCompletion(completion: Subscribers.Completion<Error>){
//        switch completion{
//        case .finished:
//            break
//        case .failure(let error):
//            Logger.debug_print(error.localizedDescription)
//        }
//    }
}
