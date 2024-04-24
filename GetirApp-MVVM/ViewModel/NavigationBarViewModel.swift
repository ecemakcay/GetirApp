//
//  NavigationBarViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import Foundation

class NavigationBarViewModel {
    
    var totalPriceDidChange: ((Double) -> Void)? {
        didSet {
            updateTotalPrice()
        }
    }
    
    private let coreDataManager = CoreDataManager.shared
    
    func updateTotalPrice() {
        let totalPrice = coreDataManager.getTotalPrice()
        totalPriceDidChange?(totalPrice) 
    }
    
    func getTotalItemCount() -> Int {
        return coreDataManager.getTotalItemCount()
    }
    
    func clearBasket(){
        coreDataManager.clearBasket()
    }
}

