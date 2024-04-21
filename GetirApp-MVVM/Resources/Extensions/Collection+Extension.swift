//
//  Collection+Extension.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 20.04.2024.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
