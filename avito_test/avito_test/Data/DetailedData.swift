//
//  DetailedData.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 26.08.2023.
//

import Foundation

struct DetailedData: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate, description, email, phoneNumber: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location, description, email, address
        case imageURL = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
}
