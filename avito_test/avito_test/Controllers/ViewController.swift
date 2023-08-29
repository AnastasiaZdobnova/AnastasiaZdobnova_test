//
//  ViewController.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 25.08.2023.
//

import UIKit
import Alamofire

enum ViewState {
    case loading
    case success
    case error(Error)
}

class ViewController: UIViewController {
    let apiManager = APIManager()
    var productData: ProductData?
    var collectionView: UICollectionView!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Проблемы с подключением"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Повторить", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.isHidden = true
        return button
    }()
    
    private var state: ViewState = .loading {
        didSet {
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchProductData()
    }
    
    //MARK: - setupUI
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
    
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
    
    //MARK: - updateUI()
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.state {
            case .loading:
                self.activityIndicator.startAnimating()
                self.collectionView.isHidden = true
                self.errorLabel.isHidden = true
                self.retryButton.isHidden = true
            case .success:
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.collectionView.reloadData()
                self.collectionView.isHidden = false
                self.errorLabel.isHidden = true
                self.retryButton.isHidden = true
            case .error(_):
                self.activityIndicator.stopAnimating()
                self.collectionView.isHidden = true
                self.errorLabel.isHidden = false
                self.retryButton.isHidden = false
                self.vibrateDevice() // Вызов метода для вибрации
            }
        }
    }
    
    //MARK: - fetchProductData()
    private func fetchProductData() {
        state = .loading
        
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json") else {
            return
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.apiManager.fetchData(url: url) { (result: APIResult<ProductData>) in
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

    //MARK: - retryButtonTapped()
    @objc private func retryButtonTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.retryButton.alpha = 0.5
            self.retryButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.retryButton.alpha = 1.0
                self.retryButton.transform = CGAffineTransform.identity
            }
            
            self.fetchProductData()
        }
    }
    
    private func vibrateDevice() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error) // Вибрация об ошибке
    }
}

//MARK: - extension UICollectionView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData?.advertisements.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        
        // Configure the cell using the data from productData
        if let product = productData?.advertisements[indexPath.item] {
            cell.setupSell(title: product.title, image: product.imageURL, price: product.price, location: product.location, date: product.createdDate)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let product = productData?.advertisements[indexPath.item] {
            print("Selected cell at id: \(product.id)")
            let secondViewController = SecondViewController() // Создание экземпляра второго контроллера
            secondViewController.id = product.id
            navigationController?.pushViewController(secondViewController, animated: true) // Переход на второй контроллер
            
        }
    }
}
