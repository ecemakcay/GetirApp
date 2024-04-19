//
//  ListingModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Foundation

struct Product: Codable {
    let id, name: String?
    let productCount: Int?
    let products: [ProductData]?
}

struct ProductData: Codable {
    let id, name: String?
    let attribute: String?
    let thumbnailURL, imageURL: String?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
}
