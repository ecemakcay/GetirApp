//
//  NetworkRequest.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Foundation

final class NetworkRequest {
    
    static let shared: NetworkRequest = {
        let instance = NetworkRequest()
        return instance
    }()
    
    func getProducts(completionHandler: @escaping (Result<Product, Error>) -> Void) {
        NetworkManager.shared.request(Endpoint.getProducts) { (result: Result<Product, NetworkError>) in
            switch result {
            case .success(let product):
                completionHandler(.success(product))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getSuggestedProducts(completionHandler: @escaping (Result<Product, Error>) -> Void) {
        NetworkManager.shared.request(Endpoint.getSuggestedProducts) { (result: Result<Product, NetworkError>) in
            switch result {
            case .success(let product):
                completionHandler(.success(product))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
