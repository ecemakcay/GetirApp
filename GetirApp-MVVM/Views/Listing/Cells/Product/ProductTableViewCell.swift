//
//  ProductTableViewCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    weak var parentViewController: ListingViewController?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.itemSize = CGSize(width: 103.67, height: 164.67)
         layout.minimumLineSpacing = 16
         layout.minimumInteritemSpacing = 16
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         UICollectionViewCell.appearance().isSelected = false
         cv.backgroundColor = .white
         return cv
     }()
    
    var products: [ProductData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCollectionView()
        setupView()
        setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func configure(with products: [ProductData]) {
        self.products = products
        collectionView.reloadData()
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false

    }
    
    private func setupView() {
           contentView.addSubview(containerView)
           
           NSLayoutConstraint.activate([
               containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
               containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
           ])
           
       }
 
    
    func setupCollectionView() {
        containerView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

}

extension ProductTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let products = products[indexPath.item]
        cell.configure(with: products)
       
        return cell
    }
    
}

extension ProductTableViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedProduct = products[indexPath.item]
        let detailViewModel = DetailViewModel(product: selectedProduct)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        parentViewController?.navigationController?.pushViewController(detailViewController, animated: true)
  
    }
    
}
