//
//  SuggestTableViewCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Color.tableViewColor
        return view
    }()
    
    private var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 92, height: 153)
         layout.minimumLineSpacing = 16
         layout.minimumInteritemSpacing = 16
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         UICollectionViewCell.appearance().isSelected = false
         cv.backgroundColor = .white
         return cv
     }()
    
    var suggestedProducts: [ProductData] = [] {
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
        self.suggestedProducts = products
        collectionView.reloadData()
//        print(suggestedProducts.first?.name)
    }
    
    func prepareCollectionView() {
//        print("PREPARECOLLECTİON ÇIKTI")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SuggestCell.self, forCellWithReuseIdentifier: "SuggestCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

    }
 
    private func setupView() {
           // UITableViewCell'e containerView'ı ekleyin
           contentView.addSubview(containerView)
           
           // containerView'a ait layout kurallarını belirleyin
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
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

}

extension SuggestTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return suggestedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestCell", for: indexPath) as! SuggestCell
        let suggest = suggestedProducts[indexPath.item]
        cell.configure(with: suggest)
       
        return cell
    }
    
}

extension SuggestTableViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
          
    }
    
}
