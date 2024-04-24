//
//  ProductCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 20.04.2024.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    // UIImageView for product image
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return imageView
    }()
    
    // UILabel for product name
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.nameFont
        label.textColor = Constants.Color.nameColor
        return label
    }()
    
    // UILabel for product price
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.priceFont
        label.textColor = Constants.Color.priceColor
        return label
    }()
    
    // UILabel for product attribute
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.attributeFont
        label.textColor = Constants.Color.attributeColor
        return label
    }()
    
    // UIButton for stepper
    private let stepperButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.layer.borderWidth = 1
        button.tintColor = Constants.Color.stepperColor
        return button
    }()
    
    // UIStepper for adding items to basket
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.isHidden = true
        return stepper
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(attributeLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(stepperButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            productImageView.widthAnchor.constraint(equalToConstant: 103.67),
            productImageView.heightAnchor.constraint(equalToConstant: 103.67),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameLabel.widthAnchor.constraint(equalToConstant: 103.67),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            priceLabel.widthAnchor.constraint(equalToConstant: 103.67),
            priceLabel.heightAnchor.constraint(equalToConstant: 19),
            
            attributeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0),
            attributeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            attributeLabel.widthAnchor.constraint(equalToConstant: 103.67),
            attributeLabel.heightAnchor.constraint(equalToConstant: 16),
            
            stepperButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stepperButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stepperButton.widthAnchor.constraint(equalToConstant: 32),
            stepperButton.heightAnchor.constraint(equalToConstant: 32),
            
            stepper.centerYAnchor.constraint(equalTo: stepperButton.centerYAnchor),
            stepper.trailingAnchor.constraint(equalTo: stepperButton.leadingAnchor, constant: -8)
        ])
    }
    
    func configure(with product: ProductData) {
        nameLabel.text = product.name ?? "name"
        priceLabel.text = product.priceText ?? "price"
        attributeLabel.text = product.attribute ?? "attribute"
        
        if let imageURLString = product.imageURL, let imageURL = URL(string: imageURLString) {
            if imageURL.scheme == "https" {
                productImageView.kf.setImage(with: imageURL)
            } else {
                productImageView.image = UIImage(named: "default")
            }
        } else {
            productImageView.image = UIImage(named: "default")
        }
    }
    
}

