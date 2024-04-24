//
//  NavigationBarItemView.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import UIKit

class NavigationBarItemView: UIView {
    
    var viewModel: NavigationBarViewModel? {
        didSet {
            observeTotalPriceChanges()
        }
    }
    
    var totalPrice: Double = 0.0 {
        didSet {
            totalPriceLabel.text = String(format: " ₺%.2f  ", totalPrice)
        }
    }
    
    var basketButtonAction: (() -> Void)?
    
    private let basketButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "basket"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .white
       
        
        return stackView
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        observeTotalPriceChanges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        observeTotalPriceChanges()
    }
    
    private func observeTotalPriceChanges() {
        viewModel?.totalPriceDidChange = { [weak self] totalPrice in
            self?.totalPrice = totalPrice
        }
    }

    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(basketButton)
        stackView.addArrangedSubview(totalPriceLabel)
        stackView.addArrangedSubview(spacerView)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
    }
    
    @objc private func basketButtonTapped() {
        basketButtonAction?()
    }

}
