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
        view.backgroundColor = .cyan
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
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.state {
            case .loading:
                self.label.text = "loading"
                // Hide or show relevant UI elements for loading state
                //self.collectionView.isHidden = true
            case .success:
                self.label.text = "ok"
               // self.label.isHidden = true
                // Update your UI to display collectionView with data
//                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//                self.collectionView.reloadData()
//                self.collectionView.isHidden = false
            case .error(let error):
                self.label.text = ("Error: \(error)")
                // Show error message or handle error state
                //self.collectionView.isHidden = true
            }
        }
    }
    func fetchProductData() {
        state = .loading
       // label.text = "loading"
        
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/details/"+id+".json") else {
            return
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            self.apiManager.fetchData(url: url) { (result: APIResult<DetailedData>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let detailedData):
                        self.productData = detailedData
                        self.state = .success
                        print(self.productData ?? "oops")
                    case .failure(let error):
                        self.state = .error(error)
                    }
                }
            }
        }
    }
}
