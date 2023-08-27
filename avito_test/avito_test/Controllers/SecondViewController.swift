//
//  SecondViewController.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 27.08.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    var id = ""
    let apiManager = APIManager()
    var productData: DetailedData?
    let label = UILabel()
    var detailedView = DetailedProductView()
    
    var state: ViewState = .loading {
        didSet {
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("Переданный id = \(id)")
        setupUI()
        fetchProductData()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        view.addSubview(label)
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailedView)
        
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.state {
            case .loading:
                self.label.text = "loading"
                self.detailedView.isHidden = true
            case .success:
                self.label.isHidden = true
                self.detailedView.isHidden = false
                
            case .error(let error):
                self.label.text = ("Error: \(error)")
                self.detailedView.isHidden = true
            }
        }
    }
    func fetchProductData() {
        state = .loading
        // label.text = "loading"
        
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/details/"+id+".json") else {
            return
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.apiManager.fetchData(url: url) { (result: APIResult<DetailedData>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let detailedData):
                        self.productData = detailedData
                        self.state = .success
                        print(self.productData ?? "oops")
                        if let product = self.productData{
                            self.detailedView.setupSell(image: product.imageURL, price: product.price, title: product.title, location: product.location, address: product.address, description: product.description)
                        }
                        print("lalalla\(self.productData?.imageURL ?? "")")
                        self.detailedView.setNeedsLayout()
                        self.detailedView.layoutIfNeeded()
                    case .failure(let error):
                        self.state = .error(error)
                    }
                }
            }
        }
    }
}
