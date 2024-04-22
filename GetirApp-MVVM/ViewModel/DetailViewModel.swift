//
//  DetailViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 20.04.2024.
//

import Foundation

class DetailViewModel {
    
    private let product: ProductData
    private var quantity: Int = 1
    
    init(product: ProductData) {
        self.product = product
    }
    
    func getProduct() -> ProductData {
        return product
    }
    
    
    func getQuantity() -> Int {
        return quantity
    }
    
    func setQuantity(_ newQuantity: Int) {
        quantity = newQuantity
    }
    
    func saveProductToCart() {
        CoreDataManager.shared.saveData(product: product, quantity: quantity)
    }
    
    func updateQuantityAndSave(newQuantity: Int) {
        setQuantity(newQuantity)
        CoreDataManager.shared.updateItemQuantity(forProductID: getProductID() ?? "123", newQuantity: newQuantity)
    }

    func getProductID() -> String? {
        return product.id
    }

}

