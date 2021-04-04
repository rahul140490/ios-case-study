//
//  APIClient.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 02/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Combine

//MARK:- API Client
struct APIClient {
    static let agent = NetworkAgent()
    
    static func status(_ response: HTTPURLResponse) -> Result<HTTPURLResponseError> {
        switch response.statusCode {
        case 200...299: return .success
        case 404: return .failure(HTTPURLResponseError.notFound)
        case 401...403, 405...500: return .failure(HTTPURLResponseError.authenticationError)
        case 501...599: return .failure(HTTPURLResponseError.badRequest)
        case 600: return .failure(HTTPURLResponseError.outdated)
        default: return .failure(HTTPURLResponseError.failed)
        }
    }
}
