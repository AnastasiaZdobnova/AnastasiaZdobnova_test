//
//  ProductData.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 26.08.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productData = try? JSONDecoder().decode(ProductData.self, from: jsonData)

import Foundation

// MARK: - ProductData
struct ProductData: Codable {
    let advertisements: [Advertisement]
}

// MARK: - Advertisement
struct Advertisement: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}

