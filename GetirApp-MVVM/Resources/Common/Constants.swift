//
//  Constants.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 18.04.2024.
//

import Foundation
import UIKit

struct Constants{
    
    struct BaseURL {
        static let baseURL: String = "https://65c38b5339055e7482c12050.mockapi.io/api"
        static let productsURL: String = "\(baseURL)/products"
        static let suggestedProductsURL: String = "\(baseURL)/suggestedProducts"
    }
    
    struct Color {
        
        static let nameColor = #colorLiteral(red: 0.1298427582, green: 0.1298427582, blue: 0.1298427582, alpha: 1)
        static let priceColor = #colorLiteral(red: 0.3647058824, green: 0.2431372549, blue: 0.737254902, alpha: 1)
        static let attributeColor = #colorLiteral(red: 0.4117647059, green: 0.4549019608, blue: 0.5333333333, alpha: 1)
        static let navBarColor = #colorLiteral(red: 0.3647058824, green: 0.2431372549, blue: 0.737254902, alpha: 1)
        static let stepperColor = #colorLiteral(red: 0.3647058824, green: 0.2431372549, blue: 0.737254902, alpha: 1)
        static let navBarTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let tableViewColor = #colorLiteral(red: 0.9626654983, green: 0.9626654983, blue: 0.9626654983, alpha: 1)
       
    }
    
    struct Fonts {
        static let nameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let priceFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        static let attributeFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        static let navBarFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
}

