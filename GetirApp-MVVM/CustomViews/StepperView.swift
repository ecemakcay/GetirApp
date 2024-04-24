//
//  StepperView.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import UIKit

class StepperView: UIView {
    
    var viewModel: StepperViewModel? {
        didSet {
            updateValueLabel()
            updateDecrementButtonIcon()
        }
    }
    
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            stackView.axis = axis
        }
    }
    
    var quantityDidChange: ((Int) -> Void)?
    
    var isChanged = false

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        stackView.layer.borderWidth = 1
        return stackView
    }()
        
    private let decrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(Constants.Color.navBarColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(Constants.Color.navBarColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = Constants.Color.navBarColor
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateDecrementButtonIcon() {
        let isTrashIconNeeded = viewModel?.isTrashIconNeeded() ?? false
        if isTrashIconNeeded {
            decrementButton.setImage(UIImage(systemName: "trash"), for: .normal)
            decrementButton.tintColor = Constants.Color.navBarColor
            decrementButton.setTitle("", for: .normal)
        } else {
            decrementButton.setImage(UIImage(systemName: ""), for: .normal)
            decrementButton.setTitle("-", for: .normal)

        }
    }

    func updateValueLabel() {
        guard let viewModel = viewModel else { return }
        valueLabel.text = "\(viewModel.getQuantity())"
        updateDecrementButtonIcon()
        
    }
    
    @objc private func decrementButtonTapped() {
        viewModel?.updateQuantityAndSave(newQuantity: (viewModel?.getQuantity() ?? 1) - 1)
        updateValueLabel()
        quantityDidChange?(viewModel?.getQuantity() ?? 1)
    }

    @objc private func incrementButtonTapped() {
        viewModel?.updateQuantityAndSave(newQuantity: (viewModel?.getQuantity() ?? 1) + 1)
        updateValueLabel()
        quantityDidChange?(viewModel?.getQuantity() ?? 1)
    }
 
    private func setupUI() {
        stackView.addArrangedSubview(decrementButton)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(incrementButton)
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let widthConstraint = stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 150)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        
        let heightConstraint = stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 48)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            decrementButton.widthAnchor.constraint(equalTo: decrementButton.heightAnchor),
            valueLabel.widthAnchor.constraint(equalTo: decrementButton.widthAnchor),
            valueLabel.heightAnchor.constraint(equalTo: decrementButton.widthAnchor),
            incrementButton.widthAnchor.constraint(equalTo: decrementButton.widthAnchor),
            decrementButton.heightAnchor.constraint(equalTo: decrementButton.widthAnchor)
            
        ])
    }

}
