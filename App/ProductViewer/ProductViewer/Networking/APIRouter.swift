//
//  APIRouter.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 02/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

//MARK:- Methods
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

//MARK:- Errors
enum HTTPURLResponseError: Error {
    case authenticationError
    case notFound
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

//MARK:- Response
enum Result<T> {
    case success
    case failure(T)
}

//MARK:- Headers
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case client = "X-APP-CLIENT"
    case forwardedHost = "X-FORWARDED-HOST"
}

enum HTTPHeaderValue {
    case json
    case multipartFormData
    
    var content: String {
        switch self {
        case .json:
            return "application/json"
        case .multipartFormData:
            return "multipart/form-data; boundary="
        }
    }
}

//MARK:- Router
enum APIRouter {
    case products
    case product(id: UInt)
    
    // MARK:- Base
    private var baseURL: URL {
        URL(string: "https://api.target.com/mobile_case_study_deals/v1")!
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .products,
             .product:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .products:
            return "/deals"
            
        case .product(let id):
            return "/deals/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: [String: Any]? {
        switch self {
        case .products:
            return nil
            
        case .product:
            return nil
        }
    }
    
    // MARK:- Request
    func request() -> URLRequest? {
        var request: URLRequest?
        
        switch method {
        case .get:
            guard var comps = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
                print("\(HTTPURLResponseError.badRequest)")
                
                return nil
            }
            comps.queryItems = parameters?.compactMap({ URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
            if let url = comps.url {
                request = URLRequest(url: url)
            } else {
                return nil
            }
            
        default:
            request = URLRequest(url: baseURL.appendingPathComponent(path))
        }
        
        request?.httpMethod = method.rawValue
        
        request?.setValue(HTTPHeaderValue.json.content, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request?.setValue(HTTPHeaderValue.json.content, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            switch method {
            case .get:
                request?.httpBody = nil
                
            default:
                do {
                    request?.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    print("\(HTTPURLResponseError.noData)")
                }
            }
        }
        
        return request
    }
}
