//
//  SuggestTableViewCell.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 92, height: 153)
         layout.minimumLineSpacing = 16
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.backgroundColor = .clear
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
        setupUI()
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
        collectionView.isUserInteractionEnabled = true
    }
 
    
    func setupUI() {
//        print("SETUPUI ÇIKTI")
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
            if let cell = collectionView.cellForItem(at: indexPath) as? SuggestCell {
                cell.isSelectedCell = true
            }
        }
    
}
