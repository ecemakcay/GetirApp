//
//  ListingViewController.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit

class ListingViewController: UIViewController {
    
    let viewModel = ListingViewModel()
    
    var suggestedProducts: [ProductData] = [] {
        didSet {
            suggestedCollectionView.reloadData()
        }
    }
    
    var products: [ProductData] = [] {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    
    private lazy var suggestedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupSuggestCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SuggestCell.self, forCellWithReuseIdentifier: "SuggestCell")
        return collectionView
    }()
    
    private lazy var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupProductCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationBar()
        
        viewModel.delegate = self
        viewModel.fetchSuggestProducts()
        viewModel.fetchProducts()
    }
    
    private func setupSuggestCollectionViewLayout() -> UICollectionViewLayout {
        // Suggest section layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
       
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }







    private func setupProductCollectionViewLayout() -> UICollectionViewLayout {
        // Product section layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Hücre içeriğinin kenar boşluklarını azaltıyoruz
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }





    private func setupCollectionView() {
        view.addSubview(suggestedCollectionView)
        view.addSubview(productsCollectionView)
        
        suggestedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Suggest Collection View Constraints
            suggestedCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            suggestedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suggestedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suggestedCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35), // Yüksekliği %35 olarak ayarladık
            
            // Product Collection View Constraints
            productsCollectionView.topAnchor.constraint(equalTo: suggestedCollectionView.bottomAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = Constants.Color.navBarColor
        navigationController?.navigationBar.barTintColor = Constants.Color.navBarColor
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.navBarTextColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationItem.title = "Ürünler"
        
        let basketButton = UIBarButtonItem(image: UIImage(systemName: "basket"), style: .plain, target: self, action: #selector(basketButtonTapped))
        let basketItemCountLabel = UILabel()
        basketItemCountLabel.text = "3"
        basketItemCountLabel.textColor = .white
        let basketItemCountBarButton = UIBarButtonItem(customView: basketItemCountLabel)
        navigationItem.rightBarButtonItems = [basketButton, basketItemCountBarButton]
    }
    
    @objc func basketButtonTapped() {
        
    }
    
}

extension ListingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestedCollectionView {
            return suggestedProducts.count
        } else if collectionView == productsCollectionView {
            return products.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == suggestedCollectionView {
            let suggestCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestCell", for: indexPath) as! SuggestCell
            suggestCell.configure(with: suggestedProducts[indexPath.item])
            return suggestCell
        } else if collectionView == productsCollectionView {
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            productCell.configure(with: products[indexPath.item])
            return productCell
        }
        fatalError("Unknown collection view")
    }
}

extension ListingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedProduct: ProductData
        if collectionView == suggestedCollectionView {
            selectedProduct = suggestedProducts[indexPath.item]
        } else if collectionView == productsCollectionView {
            selectedProduct = products[indexPath.item]
        } else {
            fatalError("Unknown collection view")
        }
        
        let detailViewModel = DetailViewModel(product: selectedProduct)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
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
        print("Önerilen ürünler alınamadı: \(error.localizedDescription)")
    }
}
