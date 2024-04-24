//
//  UIViewController+Extension.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 21.04.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setCustomBackButton() {
        let backButtonImage = UIImage(named: "x")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupNavigationBar(title: String) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Constants.Color.navBarColor
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.navBarTextColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = title
    }

    func clearBasket(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(clearButtonTapped))
        clearButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc func clearButtonTapped(){
        let viewModel = NavigationBarViewModel()
        viewModel.clearBasket()
        let vc = ListingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
