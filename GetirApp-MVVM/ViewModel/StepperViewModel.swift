//
//  StepperViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import UIKit

class StepperViewModel {
    
    private let product: ProductData
    private var quantity: Int = 1
    var quantityDidChange: ((Int) -> Void)?

    init(product: ProductData) {
        self.product = product
        self.quantity = CoreDataManager.shared.getQuantity(forProductID: getProductID() ?? "") ?? 0
    }

    func updateQuantityAndSave(newQuantity: Int) {
        setQuantity(newQuantity)
        CoreDataManager.shared.updateItemQuantity(forProductID: getProductID() ?? "123", newQuantity: newQuantity)
    }
    
    func getProduct() -> ProductData {
        return product
    }
    
    func getQuantity() -> Int {
        return CoreDataManager.shared.getQuantity(forProductID: getProductID() ?? "") ?? quantity
    }

    func setQuantity(_ newQuantity: Int) {
        quantity = newQuantity
    }

    func getProductID() -> String? {
        return product.id
    }
    
    func isTrashIconNeeded() -> Bool {
        return getQuantity() == 1
    }
}
