//
//  NetworkManager.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        AF.request(urlConvertible).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([T].self, from: data)
                  
                    if let firstItem = decodedData.first {
                        completion(.success(firstItem))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                    
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            case .failure(let error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
}
