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
        view.backgroundColor = .brown
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentWhiteView)
        contentWhiteView.addSubview(imageView)
        contentWhiteView.addSubview(titleLabel)
        
        
        NSLayoutConstraint.activate([
            
            contentWhiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: topAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
            //titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            //titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupSell(title: String, image: String){
        titleLabel.text = title
        if let imageURL = URL(string: image) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}
