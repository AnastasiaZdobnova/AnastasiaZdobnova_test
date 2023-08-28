//
//  ProductCell.swift
//  avito_test
//
//  Created by Анастасия Здобнова on 26.08.2023.
//
import Foundation
import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentWhiteView)
        contentWhiteView.addSubview(imageView)
        contentWhiteView.addSubview(titleLabel)
        contentWhiteView.addSubview(priceLabel)
        contentWhiteView.addSubview(locationLabel)
        contentWhiteView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            contentWhiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: topAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 130),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            
            dateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func setupSell(title: String, image: String, price: String, location: String, date: String){
        titleLabel.text = title
        if let imageURL = URL(string: image) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        priceLabel.text = price
        locationLabel.text = location
        dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        priceLabel.text = ""
        locationLabel.text = ""
        dateLabel.text = ""
    }
}
