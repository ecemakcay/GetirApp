//
//  Endpoint.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    
    case getProducts
    case getSuggestedProducts
    
    private var baseURL: String {
        return Constants.BaseURL.baseURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var url: URL {
        switch self {
        case .getProducts:
            return URL(string: "\(baseURL)/products")!
        case .getSuggestedProducts:
            return URL(string: "\(baseURL)/suggestedProducts")!
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
