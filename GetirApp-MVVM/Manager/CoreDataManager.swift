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
    
    func saveData(productData: ProductData, quantity: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error: Failed to get AppDelegate.")
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "BasketEntity", in: context) else {
            print("Error: Failed to create entity.")
            return
        }
        
        let basketEntity = BasketEntity(entity: entity, insertInto: context)
        basketEntity.name = productData.name
        basketEntity.price = productData.price ?? 0.00
        basketEntity.attribute = productData.attribute
        basketEntity.id = productData.id
        basketEntity.quantity = Int16(quantity)
        basketEntity.imageUrl = productData.imageURL
        
        do {
            try context.save()
            print("Success: Data saved.")
        } catch {
            print("Error: Failed to save data - \(error.localizedDescription)")
        }
    }

    
    // MARK: - Fetch Data

    func fetchData() -> [BasketItem]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<BasketEntity>(entityName: "BasketEntity")
        
        do {
            let result = try context.fetch(fetchRequest)
            let basketItems = result.compactMap { basketEntity in
                BasketItem(
                    name: basketEntity.name ?? "",
                    attribute: basketEntity.attribute ?? "",
                    price: basketEntity.price,
                    quantity: Int(basketEntity.quantity),
                    id: basketEntity.id ?? "",
                    imageURL: basketEntity.imageUrl ?? ""
                )
            }
            return basketItems
        } catch {
            print("Error: Failed to fetch data - \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Update Quantity

    func updateItemQuantity(forProductID productID: String, newQuantity: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<BasketEntity>(entityName: "BasketEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", productID)
        
        do {
            let items = try context.fetch(fetchRequest)
            
            if let item = items.first {
                if newQuantity <= 0 {
                    context.delete(item)
                } else {
                    item.quantity = Int16(newQuantity)
                }
            }
            
            try context.save()
            print("Item quantity updated successfully.")
        } catch {
            print("Error updating item quantity: \(error.localizedDescription)")
        }
    }


    
    // MARK: - Get Total Price

    func getTotalPrice() -> Double {
        guard let items = fetchData() else { return 0 }
        
        var totalPrice: Double = 0
        for item in items {
            totalPrice += (item.price ?? 0.00) * Double(item.quantity)
        }
        
        return totalPrice
    }

    
    // MARK: - Get Total Item Count

    func getTotalItemCount() -> Int {
        guard let items = fetchData() else { return 0 }
        
        var totalCount = 0
        for item in items {
            totalCount += Int(item.quantity)
        }
        
        return totalCount
    }

    // MARK: - Get Item Count

    func getQuantity(forProductID productID: String) -> Int? {
        guard let items = fetchData() else { return nil }
        
        for item in items {
            if item.id == productID {
                return Int(item.quantity)
            }
        }
        
        return nil
    }

    
    // MARK: - Delete Data

    func deleteData(forProductID productID: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<BasketEntity>(entityName: "BasketEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", productID)
        
        do {
            let items = try context.fetch(fetchRequest)
            
            if let item = items.first {
                context.delete(item)
                try context.save()
                print("Success: Data deleted.")
            } else {
                print("Error: Item with ID \(productID) not found.")
            }
        } catch {
            print("Error: Failed to delete data - \(error.localizedDescription)")
        }
    }



    
    // MARK: - Clear Basket
    
    func clearBasket() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BasketEntity")
        
        do {
            let items = try context.fetch(fetchRequest)
            for case let item as NSManagedObject in items {
                context.delete(item)
            }
            try context.save()
            print("Success: Basket cleared.")
        } catch {
            print("Error: Failed to clear basket - \(error.localizedDescription)")
        }
    }



}
