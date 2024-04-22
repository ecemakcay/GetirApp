//
//  DetailViewController.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 20.04.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel?
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.detailNameFont
        label.textColor = Constants.Color.nameColor
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.detailPriceFont
        label.textColor = Constants.Color.priceColor
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.detailAttributeFont
        label.textColor = Constants.Color.attributeColor
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.detailAttributeFont
        label.textColor = Constants.Color.attributeColor
        label.text = "1"
        label.isHidden = true
        return label
    }()
    
    private let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.isHidden = true
        stepper.tintColor = Constants.Color.navBarColor
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Color.navBarColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        configure()
        setCustomBackButton()

    }
 
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        let product = viewModel?.getProduct()
        nameLabel.text = product?.name
        priceLabel.text = product?.priceText
        attributeLabel.text = product?.attribute
        
        if let imageURLString = product?.imageURL, let imageURL = URL(string: imageURLString) {
            DispatchQueue.main.async {
                self.productImageView.kf.setImage(with: imageURL)
            }
        }
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let newQuantity = Int(sender.value)
        quantityLabel.text = "\(newQuantity)"
        
        if newQuantity == 0 {
            addToCartButton.isHidden = false
            quantityStepper.isHidden = true
            quantityLabel.isHidden = true
        }
        
        viewModel?.updateQuantityAndSave(newQuantity: newQuantity)
    }

    
    @objc func addToCartButtonTapped() {
        viewModel?.saveProductToCart()
        quantityStepper.value = 1
        quantityLabel.text = "1"
        
        addToCartButton.isHidden = true
        quantityStepper.isHidden = false
        quantityLabel.isHidden = false
    }
    
    
    func setupConstraints(){
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.addSubview(productImageView)
        topView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(attributeLabel)
        
        bottomView.addSubview(addToCartButton)
        bottomView.addSubview(quantityLabel)
        bottomView.addSubview(quantityStepper)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            productImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            addToCartButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            addToCartButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 343),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            
            quantityStepper.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            quantityStepper.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            quantityLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            quantityLabel.topAnchor.constraint(equalTo: quantityStepper.bottomAnchor, constant: 8)
        ])
    }
    
}
