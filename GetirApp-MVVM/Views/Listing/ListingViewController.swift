//
//  ListingViewController.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit

class ListingViewController: UIViewController {
    
    let viewModel = ListingViewModel()
    
    var suggestedProducts: [ProductData] = []{
        didSet {
           
            tableView.reloadData()
        }
    }
    
    var products: [ProductData] = []{
        didSet {
           
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
         let tableView = UITableView(frame: .zero, style: .grouped)
         tableView.backgroundColor = Constants.Color.tableViewColor
         UITableViewCell.appearance().selectionStyle = .none
         tableView.separatorStyle = .none
         return tableView
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupTableConstraits()
        setupNavigationBar()
       
        viewModel.delegate = self
        viewModel.fetchSuggestProducts()
        viewModel.fetchProducts()
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        
        tableView.register(SuggestTableViewCell.self, forCellReuseIdentifier: "SuggestTableViewCell")
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    func setupTableConstraits() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = Constants.Color.navBarColor
        navigationController?.navigationBar.barTintColor = Constants.Color.navBarColor

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.navBarTextColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
       
        let basketButton = UIBarButtonItem(image: UIImage(systemName: "basket"), style: .plain, target: self, action: #selector(basketButtonTapped))
        let basketItemCountLabel = UILabel()
        basketItemCountLabel.text = "3"
        basketItemCountLabel.textColor = .white
        let basketItemCountBarButton = UIBarButtonItem(customView: basketItemCountLabel)
        self.navigationItem.rightBarButtonItems = [basketButton, basketItemCountBarButton]
    }

    @objc func basketButtonTapped() {
        
    }

}


extension ListingViewController: ListingViewModelDelegate {
    func didFetchProducts(products: [ProductData]) {
        self.products = products
    }
    
    func fetchProductsFailed(withError error: Error) {
        print("Ürünler alınamadı: \(error.localizedDescription)")
    }
    
    func didFetchSuggestProducts(products: [ProductData]) {
        suggestedProducts = products
    }
    
    func fetchSuggestProductsFailed(withError error: Error) {
        print("Ürünler alınamadı: \(error.localizedDescription)")
    }
}


extension ListingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let suggestCell = tableView.dequeueReusableCell(withIdentifier: "SuggestTableViewCell", for: indexPath) as! SuggestTableViewCell
            suggestCell.configure(with: self.suggestedProducts)
           
            return suggestCell
        } else {
            let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            productCell.configure(with: self.products)
            return productCell
        }
        
       
    }
    
    
}

extension ListingViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
          tableView.deselectRow(at: indexPath, animated: true)
      }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 185
        }else{
            return 558
        }
            
    }

}
