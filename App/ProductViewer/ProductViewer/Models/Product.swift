//
//  Product.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 02/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct ProductList: Codable {
    var products: [Product]?
}

struct Product: Codable {
    var id: UInt?
    var title: String?
    var aisle: String?
    var description: String?
    var imageURL: String?
    var regularPrice: PriceDetails?
    var salePrice: PriceDetails?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case description
        case imageURL = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
    }
}

struct PriceDetails: Codable {
    var amountInCents: UInt?
    var symbol: String?
    var displayString: String?
    
    enum CodingKeys: String, CodingKey {
        case amountInCents = "amount_in_cents"
        case symbol = "currency_symbol"
        case displayString = "display_string"
    }
}
