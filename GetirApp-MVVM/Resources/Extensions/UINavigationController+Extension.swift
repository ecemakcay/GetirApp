//
//  UINavigationController+Extension.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import UIKit

extension UINavigationController {
    private var navigationBarViewModel: NavigationBarViewModel {
        let viewModel = NavigationBarViewModel()
        let navigationBarItemView = NavigationBarItemView()
        navigationBarItemView.viewModel = viewModel
        return viewModel

    }

    func updateNavigationBarItem() {
        navigationBarViewModel.totalPriceDidChange = { totalPrice in 
            DispatchQueue.main.async { [weak self] in
                let containerView = NavigationBarItemView(frame: CGRect(x: 0, y: 0, width: 91, height: 34))
                containerView.totalPrice = totalPrice
                containerView.basketButtonAction = { [weak self] in
                    self?.navigateToBasket()
                }
                let barButtonItem = UIBarButtonItem(customView: containerView)
                self?.navigationBar.topItem?.rightBarButtonItem = barButtonItem
            }
        }
        navigationBarViewModel.updateTotalPrice()
    }


    
    func navigateToBasket() {
        let totalItemCount = navigationBarViewModel.getTotalItemCount()
        let basketVC = BasketViewController()
        
        guard totalItemCount > 0 else {return}
         self.pushViewController(basketVC, animated: true)
    }

}
