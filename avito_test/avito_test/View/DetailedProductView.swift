//
//  DetailedProductView.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 27.08.2023.
//

import UIKit
import SDWebImage

class DetailedProductView: UIView {
    
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
        imageView.layer.cornerRadius = 5
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
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentWhiteView)
        contentWhiteView.addSubview(imageView)
        contentWhiteView.addSubview(priceLabel)
        contentWhiteView.addSubview(titleLabel)
        contentWhiteView.addSubview(locationLabel)
        contentWhiteView.addSubview(addressLabel)
        contentWhiteView.addSubview(descriptionLabelName)
        contentWhiteView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            contentWhiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: topAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            addressLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            
            descriptionLabelName.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            descriptionLabelName.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 40),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabelName.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionLabelName.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -15)
//
//            dateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
//            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4)
        ])
    }
    
//    func setupSell(title: String, image: String, price: String, location: String, date: String){
    func setupSell(image: String, price: String, title: String,  location: String, address: String, description: String){
        if let imageURL = URL(string: image) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        priceLabel.text = price
        titleLabel.text = title
        locationLabel.text = location
        addressLabel.text = address
        descriptionLabel.text = description
//        dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
