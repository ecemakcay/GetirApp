//
//  ListingViewModel.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Foundation

protocol ListingViewModelDelegate: AnyObject {
    func didFetchSuggestProducts(products: [ProductData])
    func fetchSuggestProductsFailed(withError error: Error)
}

class ListingViewModel {
    weak var delegate: ListingViewModelDelegate?
    var products: [ProductData] = []
    
    func fetchSuggestProducts() {
        NetworkRequest.shared.getSuggestedProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responce):
                self.products = responce.products ?? []
                self.delegate?.didFetchSuggestProducts(products: responce.products ?? [])
            case .failure(let error):
                self.delegate?.fetchSuggestProductsFailed(withError: error)
            }
        }
    }
}
