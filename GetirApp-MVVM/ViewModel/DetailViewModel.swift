//
//  DetailViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 20.04.2024.
//

import Foundation

class DetailViewModel {
    
    private let product: ProductData
    
    init(product: ProductData) {
        self.product = product
    }
    
    func getProduct() -> ProductData {
        return product
    }
    
    func getQuantity() -> Int {
        return CoreDataManager.shared.getQuantity(forProductID: getProductID() ?? "") ?? 0
    }
   
    func saveProductToCart() {
        CoreDataManager.shared.saveData(productData: product, quantity: 1)
    }

    func getProductID() -> String? {
        return product.id
    }
}
