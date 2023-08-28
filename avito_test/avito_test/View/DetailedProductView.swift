//
//  DetailedProductView.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 27.08.2023.
//

import UIKit
import SDWebImage

class DetailedProductView: UIView {
    
    var controller = UIViewController()
    var email = ""
    var number = ""
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    let telephoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Позвонить", for: .normal)
        button.backgroundColor = UIColor(
            red: CGFloat(0x39) / 255.0,
            green: CGFloat(0xC7) / 255.0,
            blue: CGFloat(0x58) / 255.0,
            alpha: 1.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        return button
    }()
    
    let emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Написать", for: .normal)
        button.backgroundColor = UIColor(
            red: CGFloat(0x17) / 255.0,
            green: CGFloat(0x8F) / 255.0,
            blue: CGFloat(0xE7) / 255.0,
            alpha: 1.0
        )
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        return button
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let descriptionLabelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Описание"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let idlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.addSubview(contentWhiteView)
        contentWhiteView.addSubview(imageView)
        contentWhiteView.addSubview(priceLabel)
        contentWhiteView.addSubview(titleLabel)
        contentWhiteView.addSubview(telephoneButton)
        contentWhiteView.addSubview(emailButton)
        contentWhiteView.addSubview(locationLabel)
        contentWhiteView.addSubview(addressLabel)
        contentWhiteView.addSubview(descriptionLabelName)
        contentWhiteView.addSubview(descriptionLabel)
        contentWhiteView.addSubview(idlabel)
        contentWhiteView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentWhiteView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant:  (UIScreen.main.bounds.width)),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            telephoneButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            telephoneButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            telephoneButton.heightAnchor.constraint(equalToConstant: 45),
            
            emailButton.leadingAnchor.constraint(equalTo: telephoneButton.trailingAnchor, constant: 10),
            emailButton.topAnchor.constraint(equalTo: telephoneButton.topAnchor),
            emailButton.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -15),
            emailButton.heightAnchor.constraint(equalTo: telephoneButton.heightAnchor),
            emailButton.widthAnchor.constraint(equalTo: telephoneButton.widthAnchor),

            locationLabel.leadingAnchor.constraint(equalTo: telephoneButton.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: telephoneButton.bottomAnchor, constant: 30),
            
            addressLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            
            descriptionLabelName.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            descriptionLabelName.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 25),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabelName.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionLabelName.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -15),
            
            idlabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            idlabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: idlabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: idlabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -20),
        ])
        
        telephoneButton.addTarget(controller, action: #selector(telephoneButtonTapped), for: .touchUpInside)
        emailButton.addTarget(controller, action: #selector(emailButtonTapped), for: .touchUpInside)
        
    }

    func setupDatailedproductView(controller: UIViewController,image: String, price: String, title: String,  location: String, address: String, description: String, email: String, number: String, id: String, date: String){
        if let imageURL = URL(string: image) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        priceLabel.text = price
        titleLabel.text = title
        locationLabel.text = location
        addressLabel.text = address
        descriptionLabel.text = description
        self.email = email
        self.number = number
        self.controller = controller
        idlabel.text = "Объявление №\(id)"
        dateLabel.text = date
    }
    
    @objc private func telephoneButtonTapped() {
        let cleanedPhoneNumber = self.number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        print("cleanedPhoneNumber \(cleanedPhoneNumber)")
        if let url = URL(string: "tel://+\(cleanedPhoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func emailButtonTapped() {
        print(self.email)
        if let url = URL(string: "mailto:\(self.email)") {
            UIApplication.shared.open(url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
