//
//  NetworkAgent.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 02/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Combine

struct NetworkAgent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { result -> Response<T> in
                logResponse(result.response, request: request, data: result.data)
                
                // check for the response status
                if let httpURLResponse = result.response as? HTTPURLResponse {
                    let networkResponse = APIClient.status(httpURLResponse)
                    switch networkResponse {
                    case .success:
                        break
                    case .failure(let error):
                        throw error
                    }
                }
                
                // map response and return in case of a successful request
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func runUpload<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { result -> Response<T> in
                logResponse(result.response, request: request, data: result.data)
                
                // check for the response status
                if let httpURLResponse = result.response as? HTTPURLResponse {
                    let networkResponse = APIClient.status(httpURLResponse)
                    switch networkResponse {
                    case .success:
                        break
                    case .failure(let error):
                        throw error
                    }
                }
                
                // map response and return in case of a successful request
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func logResponse(_ urlResponse: URLResponse, request: URLRequest, data: Data?) {
        if let response = urlResponse as? HTTPURLResponse {
            print("\n***************************************************\nAPI Request -\n\nURL: \(request.url?.absoluteString ?? "")\n\nStatus: \(response.statusCode)\n\nHeaders: \(request.allHTTPHeaderFields ?? [String: String]())\n\nBody: \(request.httpBody?.prettyPrintedJSONString ?? "body isn't available")\n\nResponse: \(data?.prettyPrintedJSONString ?? "no response")\n\n***************************************************\n\n")
        }
    }
}
