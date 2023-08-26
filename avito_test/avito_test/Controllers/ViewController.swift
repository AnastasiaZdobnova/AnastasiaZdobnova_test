//
//  ViewController.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 25.08.2023.
//

import UIKit

class ViewController: UIViewController {
    let apiManager = APIManager()
    var productData: ProductData?
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        // Устанавливаем позицию и размер UILabel
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        // Добавляем UILabel на экран
        view.addSubview(label)
        fetchProductData()
    }
    
    func fetchProductData() {
        label.text = "loading"
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json") else {
            return
        }
        
        apiManager.fetchData(url: url) { (result: APIResult<ProductData>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let productData):
                    self.productData = productData
                    self.label.text = "загрузилось"
                    print(productData)
                case .failure(let error):
                    self.label.text = ("Error: \(error)")
                }
            }
        }
    }
}

