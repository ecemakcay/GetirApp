//
//  BasketViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 23.04.2024.
//

import Foundation

class BasketViewModel {
    
    var delegate: BasketViewModelDelegate?
    private let coreDataManager = CoreDataManager.shared
    
    var basketItems: [BasketItem] = [] {
        didSet {
            delegate?.didFetchBasketItems(items: basketItems)
            print(basketItems)
        }
    }
    
    func fetchBasketItems() {
        guard let basketItems = coreDataManager.fetchData() else {
            delegate?.fetchBasketItemsFailed(withError: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch basket items."]))
            return
        }
        self.basketItems = basketItems
    }

    
    func updateItemQuantity(forProductID productID: String, newQuantity: Int) {
        coreDataManager.updateItemQuantity(forProductID: productID, newQuantity: newQuantity)
        fetchBasketItems()
    }
    
    func getTotalPrice() -> Double {
        print(coreDataManager.getTotalPrice())
        return coreDataManager.getTotalPrice()
    }
    
    func getTotalItemCount() -> Int {
        print(coreDataManager.getTotalItemCount())
        return coreDataManager.getTotalItemCount()
        
    }
    
    func getQuantity(forProductID productID: String) -> Int? {
        return coreDataManager.getQuantity(forProductID: productID)
    }
    
    func clearBasket() {
        coreDataManager.clearBasket()
        fetchBasketItems()
    }
}

protocol BasketViewModelDelegate: AnyObject {
    func didFetchBasketItems(items: [BasketItem])
    func fetchBasketItemsFailed(withError error: Error)
}
