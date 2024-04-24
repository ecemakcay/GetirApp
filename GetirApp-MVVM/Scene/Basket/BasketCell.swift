//
//  BasketCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 23.04.2024.
//

import UIKit
import Kingfisher

class BasketCell: UITableViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return imageView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Constants.Color.priceColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepperView: StepperView = {
        let stepper = StepperView()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.isUserInteractionEnabled = true
        stepper.axis = .horizontal
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(stepperView)
        
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(attributeLabel)
        infoStackView.addArrangedSubview(priceLabel)
        
          let infoStackWidthConstraint = infoStackView.widthAnchor.constraint(equalTo: stepperView.widthAnchor, multiplier: 1.25)
          infoStackWidthConstraint.priority = .defaultHigh
          infoStackWidthConstraint.isActive = true
          
          NSLayoutConstraint.activate([
              productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
              productImageView.widthAnchor.constraint(equalToConstant: 74),
              productImageView.heightAnchor.constraint(equalToConstant: 74),
              productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
              productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
              
              infoStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
              infoStackView.topAnchor.constraint(equalTo: productImageView.topAnchor),
              infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
              infoStackView.trailingAnchor.constraint(equalTo: stepperView.leadingAnchor, constant: -16),
              
              stepperView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
              stepperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
          ])
    }
    
    func configure(with item: BasketItem) {
        let productData = ProductData(
            id: item.id,
            name: item.name,
            attribute: item.attribute,
            thumbnailURL: nil,
            imageURL: item.imageURL,
            price: item.price,
            priceText: nil,
            shortDescription: nil
        )
        
        stepperView.viewModel = StepperViewModel(product: productData)
        stepperView.updateValueLabel()
        stepperView.quantityDidChange = { [weak self] newQuantity in
            self?.stepperView.viewModel?.updateQuantityAndSave(newQuantity: newQuantity)
        }
        
        nameLabel.text = item.name ?? "name"
        attributeLabel.text = item.attribute ?? "attribute"
        priceLabel.text = String(format: "₺%.2f", item.price ?? 0.00)
        
        if let imageURLString = item.imageURL, let imageURL = URL(string: imageURLString) {
            if imageURL.scheme == "https" {
                DispatchQueue.main.async {
                    self.productImageView.kf.setImage(with: imageURL)
                }
            } else {
                productImageView.image = UIImage(named: "default")
            }
        } else {
            productImageView.image = UIImage(named: "default")
        }
        
        
    }

}

