//
//  CoreDataManager.swift
//  GetirApp-MVVM
//
//  Created by Ecem Akçay on 22.04.2024.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Save Data
    
    func saveData(product: ProductData, quantity: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Basket", in: context) {
            let newItem = NSManagedObject(entity: entity, insertInto: context)
            newItem.setValue(product.name, forKey: "name")
            newItem.setValue(product.priceText, forKey: "price")
            newItem.setValue(product.attribute, forKey: "attribute")
            newItem.setValue(product.id, forKey: "id")
            newItem.setValue(quantity, forKey: "quantity")
            
            if let imageURLString = product.imageURL,
               let imageURL = URL(string: imageURLString),
               let imageData = try? Data(contentsOf: imageURL) {
                newItem.setValue(imageData, forKey: "image")
            }
            
            do {
                try context.save()
                print("Success: Data saved.")
            } catch {
                print("Error: Failed to save data - \(error.localizedDescription)")
            }
        } else {
            print("Error: Failed to create entity.")
        }
    }
    
    // MARK: - Fetch Data
    
    func fetchData() -> [NSManagedObject]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Basket")
        
        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            print("Error: Failed to fetch data - \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Update Quantity
    
    func updateItemQuantity(forProductID productID: String, newQuantity: Int) {
        guard let items = fetchData() else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for item in items {
            if let id = item.value(forKey: "id") as? String, id == productID {
                
                if newQuantity <= 0 {

                    context.delete(item)
                    do {
                        try context.save()
                        print("Item quantity updated successfully. Item deleted.")
                    } catch {
                        print("Error updating item quantity: \(error.localizedDescription)")
                    }
                } else {
                    
                    item.setValue(newQuantity, forKey: "quantity")
                    do {
                        try context.save()
                        print("Item quantity updated successfully.")
                    } catch {
                        print("Error updating item quantity: \(error.localizedDescription)")
                    }
                }
                return
            }
        }
        
        print("Item with ID \(productID) not found.")
    }

    
    // MARK: - Get Total Price
    
    func getTotalPrice() -> Double {
        guard let items = fetchData() else { return 0 }
        
        var totalPrice: Double = 0
        for item in items {
            if let price = item.value(forKey: "price") as? String,
               let quantity = item.value(forKey: "quantity") as? Int,
               let priceDouble = Double(price) {
                totalPrice += priceDouble * Double(quantity)
            }
        }
        
        return totalPrice
    }
    
    // MARK: - Get Total Item Count

    func getTotalItemCount() -> Int {
        guard let items = fetchData() else { return 0 }
        
        var totalCount = 0
        for item in items {
            if let quantity = item.value(forKey: "quantity") as? Int {
                totalCount += quantity
            }
        }
        
        return totalCount
    }
    
    // MARK: - Delete Data

    func deleteData(item: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(item)
        
        do {
            try context.save()
            print("Success: Data deleted.")
        } catch {
            print("Error: Failed to delete data - \(error.localizedDescription)")
        }
    }

    
    // MARK: - Clear Basket
    
    func clearBasket() {
        guard let items = fetchData() else { return }
        
        for item in items {
            deleteData(item: item)
        }
    }
}
