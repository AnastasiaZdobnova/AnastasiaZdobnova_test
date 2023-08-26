//
//  APIManager.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 26.08.2023.
//

import Foundation
class APIManager {
    func fetchData (url: URL, controller: ViewController) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                controller.label.text = ("Error: \(error)")
                return
            }
            
            guard let data = data else {
                controller.label.text = ("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let productData = try decoder.decode(ProductData.self, from: data)
                
                // Обработайте полученные данные, например, отобразите их на экране
                print(productData.advertisements)
                controller.label.text = "загрузилось"
            } catch {
                controller.label.text = ("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
