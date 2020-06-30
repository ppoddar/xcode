import Foundation
import UIKit
/*
 * Set of OrderItem indexed by item sku
 * The keys are ordered by order of insertion
 */
class Cart : NSObject,ObservableObject, Decodable {
    
    var items = Dictionary<String,OrderItem>()
    var sku_order:[String] = [String]()
    /*
     * gets item
     */
    func getItemAt(_ idx:Int) -> OrderItem  {
        let sku:String = sku_order[idx]
        return items[sku]!
    }
    /*
     * adds given item to cart
     * If item sku exists, then existing item is replaced
     * If new item is added, sends notification
     */
    func setItem(item:Item, units:Int, comment:String) {
        print("Cart.setItem \(units) units of sku=\(item.sku)")
        notify()
        guard var existing = self.items[item.sku] else {
            sku_order.insert(item.sku, at: 0)
            let orderitem = OrderItem(
                sku: item.sku,
                name:item.name,
                units: units,
                comment: comment,
                price: Double(units)*item.price)
            self.items[item.sku] = orderitem
            return
        }
        existing.units   = units
        existing.comment = comment
        existing.price = Double(units) * item.price
        self.items[item.sku] = existing
        
        
    }
    
    func notify() {
        NotificationCenter.default.post(
        name: .itemInsertedInCart,
        object: nil)
    }
}


