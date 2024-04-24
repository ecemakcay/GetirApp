//
//  BasketViewController.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 23.04.2024.
//

import UIKit

class BasketViewController: UIViewController {
    
    let viewModel = BasketViewModel()
    
    var basketItems: [BasketItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.secondarySystemBackground
        return tableView
    }()
    
    private let checkoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Siparişi Tamamla", for: .normal)
        button.titleLabel?.font = Constants.Fonts.basketButtonFont
        button.backgroundColor = Constants.Color.navBarColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.textAlignment = .center
        label.font = Constants.Fonts.basketPriceFont
        label.textColor = Constants.Color.priceColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupCheckoutView()
        
        setupNavigationBar(title: "Sepetim")
        setCustomBackButton()
        clearBasket()
        
        viewModel.delegate = self
        viewModel.fetchBasketItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTotalPrice()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketCell.self, forCellReuseIdentifier: "BasketCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }

    private func setupCheckoutView() {
        view.addSubview(checkoutView)
        checkoutView.addSubview(checkoutButton)
        checkoutView.addSubview(totalPriceLabel)
        
        NSLayoutConstraint.activate([
            checkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkoutView.heightAnchor.constraint(equalToConstant: 100),
            
            checkoutButton.leadingAnchor.constraint(equalTo: checkoutView.leadingAnchor, constant: 16),
            checkoutButton.centerYAnchor.constraint(equalTo: checkoutView.centerYAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40),
            
            totalPriceLabel.leadingAnchor.constraint(equalTo: checkoutButton.trailingAnchor, constant: 16),
            totalPriceLabel.trailingAnchor.constraint(equalTo: checkoutView.trailingAnchor, constant: -16),
            totalPriceLabel.centerYAnchor.constraint(equalTo: checkoutView.centerYAnchor)
        ])
        
        checkoutButton.widthAnchor.constraint(equalTo: totalPriceLabel.widthAnchor, multiplier: 1.75).isActive = true
        
        checkoutButton.layer.cornerRadius = 10
        checkoutButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkoutButtonTapped() {
        let vc = ListingViewController()
        navigationController?.pushViewController(vc, animated: true)
        viewModel.clearBasket()
        showAlert(alertText: "Sipariş Tamamlandı!", alertMessage: "")
    }
}

extension BasketViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        let item = viewModel.basketItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
}

extension BasketViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BasketViewController: BasketViewModelDelegate {
    func didFetchBasketItems(items: [BasketItem]) {
        self.basketItems = items
        updateTotalPrice()
    }
    
    func fetchBasketItemsFailed(withError error: Error) {
        print("Ürünler alınamadı: \(error.localizedDescription)")
    }
    
    private func updateTotalPrice() {
        let totalPrice = viewModel.getTotalPrice()
        totalPriceLabel.text = String(format: "₺%.2f", totalPrice)
    }
}
