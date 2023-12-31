//
//  SecondViewController.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 27.08.2023.
//

import UIKit
import CoreLocation
import MapKit

class SecondViewController: UIViewController {
    
    var id = ""
    let apiManager = APIManager()
    var productData: DetailedData?
    var detailedView = DetailedProductView()
    
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
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        fetchProductData()
        setupNavigationBar()
    }
    
    //MARK: - setupUI()
    private func setupUI() {
        
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        detailedView.controller = self
        view.addSubview(detailedView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
                self.errorLabel.isHidden = true
                self.retryButton.isHidden = true
                self.detailedView.isHidden = true
            case .success:
                self.activityIndicator.stopAnimating()
                self.errorLabel.isHidden = true
                self.retryButton.isHidden = true
                self.detailedView.isHidden = false
                
            case .error(_):
                self.activityIndicator.stopAnimating()
                self.errorLabel.isHidden = false
                self.retryButton.isHidden = false
                self.vibrateDevice() // Вызов метода для вибрации
                self.detailedView.isHidden = true
            }
        }
    }
    //MARK: - fetchProductData()
    func fetchProductData() {
        state = .loading
        
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
                        if let product = self.productData{
                            self.detailedView.setupDatailedproductView(controller: self, image: product.imageURL, price: product.price, title: product.title, location: product.location, address: product.address, description: product.description, email: product.email, number: product.phoneNumber, id: product.id, date: product.createdDate)
                        }
                        self.detailedView.setNeedsLayout()
                        self.detailedView.layoutIfNeeded()
                        self.detailedView.telephoneButton.addTarget(self, action: #selector(self.telephoneButtonTapped), for: .touchUpInside)
                        self.detailedView.emailButton.addTarget(self, action: #selector(self.emailButtonTapped), for: .touchUpInside)
                    case .failure(let error):
                        self.state = .error(error)
                    }
                }
            }
        }
    }
    //MARK: - setupNavigationBar()
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor =  UIColor(named: "adaptiveBlack")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Информация о товаре"
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - retryButtonTapped()
    @objc private func retryButtonTapped() {
        animateButtonPress(for: retryButton)
        self.fetchProductData()
    }
    
    private func vibrateDevice() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    @objc private func telephoneButtonTapped() {
        animateButtonPress(for: detailedView.telephoneButton)
        let cleanedPhoneNumber = detailedView.number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if let url = URL(string: "tel://+\(cleanedPhoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func emailButtonTapped() {
        animateButtonPress(for: detailedView.emailButton)
        if let url = URL(string: "mailto:\(detailedView.email)") {
            UIApplication.shared.open(url)
        }
    }
    
    private func animateButtonPress(for button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.alpha = 0.5
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                button.alpha = 1.0
                button.transform = CGAffineTransform.identity
            }
        }
    }
}
