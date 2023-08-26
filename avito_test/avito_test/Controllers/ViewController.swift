////
////  ViewController.swift
////  avito_test
////
////  Created by Анастасия Здобнова on 25.08.2023.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    let apiManager = APIManager()
//    var productData: ProductData?
//    let label = UILabel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .green
//        label.textAlignment = .center
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 24)
//        
//        // Устанавливаем позицию и размер UILabel
//        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
//        // Добавляем UILabel на экран
//        view.addSubview(label)
//        fetchProductData()
//    }
//    
//    func fetchProductData() {
//        label.text = "loading"
//        guard let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json") else {
//            return
//        }
//        
//        apiManager.fetchData(url: url) { (result: APIResult<ProductData>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let productData):
//                    self.productData = productData
//                    self.label.text = "загрузилось"
//                    print(productData)
//                case .failure(let error):
//                    self.label.text = ("Error: \(error)")
//                }
//            }
//        }
//    }
//}
//

import UIKit

enum ViewState {
    case loading
    case success
    case error(Error)
}

class ViewController: UIViewController {
    let apiManager = APIManager()
    var productData: ProductData?
    let label = UILabel()
    var collectionView: UICollectionView!
    
    var state: ViewState = .loading {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupUI()
        fetchProductData()
    }
    
    private func setupUI() {
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        view.addSubview(label)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height - 150), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.state {
            case .loading:
                self.label.text = "loading"
                // Hide or show relevant UI elements for loading state
                self.collectionView.isHidden = true
            case .success:
                self.label.isHidden = true
                // Update your UI to display collectionView with data
                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.collectionView.reloadData()
                self.collectionView.isHidden = false
            case .error(let error):
                self.label.text = ("Error: \(error)")
                // Show error message or handle error state
                self.collectionView.isHidden = true
            }
        }
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
                    self.state = .success
                    print(productData)
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData?.advertisements.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        
        // Display title in cell
        if let title = productData?.advertisements[indexPath.item].title {
            let titleLabel = UILabel(frame: cell.contentView.bounds)
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.textColor = .black
            cell.contentView.addSubview(titleLabel)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 50)
    }
}
