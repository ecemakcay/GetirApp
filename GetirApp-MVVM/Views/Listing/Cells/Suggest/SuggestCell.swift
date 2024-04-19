//
//  SuggestCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit
import Kingfisher

class SuggestCell: UICollectionViewCell {
    
    var isSelectedCell: Bool = false {
        didSet {
            contentView.backgroundColor = isSelectedCell ? UIColor.lightGray : Constants.Color.navBarColor
        }
    }
    
    // UIImageView for product image
    private let productImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFill
         imageView.layer.cornerRadius = 16
         imageView.layer.borderWidth = 1
         imageView.layer.borderColor = UIColor.lightGray.cgColor
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
           button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
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
           stepper.isHidden = true // initially hidden
           return stepper
       }()
        
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupSubviews()
//         print("SuggestCell init çalıştı")
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     private func setupSubviews() {
//         print("setupSubviews çalıştı")

         contentView.addSubview(productImageView)
         contentView.addSubview(nameLabel)
         contentView.addSubview(priceLabel)
         contentView.addSubview(attributeLabel)
         contentView.addSubview(stepper)
         contentView.addSubview(stepperButton)
         
         // Configure constraints for subviews
           NSLayoutConstraint.activate([
               // Product Image View Constraints
               productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               productImageView.widthAnchor.constraint(equalToConstant: 92),
               productImageView.heightAnchor.constraint(equalToConstant: 92),
               
               // Name Label Constraints
               nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
               nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               nameLabel.widthAnchor.constraint(equalToConstant: 92),
               nameLabel.heightAnchor.constraint(equalToConstant: 16),
               
               // Price Label Constraints
               priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
               priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               priceLabel.widthAnchor.constraint(equalToConstant: 92),
               priceLabel.heightAnchor.constraint(equalToConstant: 19),
               
               // Attribute Label Constraints
               attributeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0),
               attributeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               attributeLabel.widthAnchor.constraint(equalToConstant: 92),
               attributeLabel.heightAnchor.constraint(equalToConstant: 16),

               
               // Stepper Button Constraints
               stepperButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               stepperButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
               stepperButton.widthAnchor.constraint(equalToConstant: 32),
               stepperButton.heightAnchor.constraint(equalToConstant: 32),
               
               // Stepper Constraints
               stepper.centerYAnchor.constraint(equalTo: stepperButton.centerYAnchor),
               stepper.trailingAnchor.constraint(equalTo: stepperButton.leadingAnchor, constant: -8)
           ])
     }
    
    func configure(with product: ProductData) {
    
        nameLabel.text = product.name ?? "name"
        priceLabel.text = product.priceText ?? "price"
        attributeLabel.text = product.attribute ?? "attribute"
        
        if let imageURLString = product.imageURL, let imageURL = URL(string: imageURLString) {
            DispatchQueue.main.async {
                self.productImageView.kf.setImage(with: imageURL)
            }
        }
    }
    
}
