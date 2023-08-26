//
//  APIManager.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 26.08.2023.
//

import Foundation
class APIManager {
    func fetchData<T: Decodable>(url: URL, controller: ViewController, responseType: T.Type) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                controller.label.text = ("Error: \(error)")
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                controller.label.text = ("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(responseType, from: data)
                
                // Обработайте полученные данные, например, отобразите их на экране
                if let productData = decodedData as? T {
                    print(productData)
                }
                
                controller.label.text = "загрузилось"
            } catch {
                print("Error: \(error)")
                controller.label.text = ("Error decoding JSON: \(error)")
                
            }
        }.resume()
    }
}







