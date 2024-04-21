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
}

