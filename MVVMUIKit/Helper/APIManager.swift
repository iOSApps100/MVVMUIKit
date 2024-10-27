//
//  APIManager.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 19/10/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

//typealias Hanlder = (Result<[Product], DataError>) -> Void
typealias Hanlder<T> = (Result<T, DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(modelType: T.Type, type: EndPointType, completion: @escaping Hanlder<T>) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // converting get to post request
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type" : "application/json"
        ]
    }
    
//    func fetchProducts(completion: @escaping Hanlder) {
//        
//        guard let url = URL(string: Constant.API.productURL) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data, error == nil else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            do {
//                let products = try JSONDecoder().decode([Product].self, from: data)
//                completion(.success(products))
//            } catch {
//                completion(.failure(.network(error)))
//            }
//        }.resume()
//    }
}
