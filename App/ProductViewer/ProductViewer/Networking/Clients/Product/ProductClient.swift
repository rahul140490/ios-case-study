//
//  ProductClient.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 02/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Combine

struct ProductClient {
    static func resquestProductList() -> AnyPublisher<ProductList, Error> {
        guard let request = APIRouter.products.request() else {
            return Fail<ProductList, Error>(error: HTTPURLResponseError.badRequest).eraseToAnyPublisher()
        }
        
        return APIClient.agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func requestProductDetails(id: UInt) -> AnyPublisher<Product, Error> {
        guard let request = APIRouter.product(id: id).request() else {
            return Fail<Product, Error>(error: HTTPURLResponseError.badRequest).eraseToAnyPublisher()
        }
        
        return APIClient.agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
