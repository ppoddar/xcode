import Foundation
/*
 * Set of OrderItem indexed by item sku
 * The keys are ordered by order of insertion
 */
class Cart : NSObject,ObservableObject,Codable {
    
    var items = IndexedDictionary<OrderItem>()
    
    /*
     * adds given item to cart
     * If item sku exists, then existing item is replaced
     * If new item is added, sends notification
     */
    func setItem(item:Item, units:Int, comment:String) {
        NSLog("Cart.setItem \(units) units of sku=\(item.sku)")
        notify()
        guard var existing:OrderItem = self.items[item.sku] else {
            let orderitem = OrderItem(
                sku: item.sku,
                name:item.name,
                units: units,
                comment: comment,
                price: Double(units)*item.price)
            self.items.setValue(key:item.sku, value: orderitem)
            return
        }
        existing.units   = units
        existing.comment = comment
        existing.price = Double(units) * item.price
        self.items.setValue(key:item.sku, value:existing)
    }
    
    func notify() {
        NotificationCenter.default.post(
        name: .itemInsertedInCart,
        object: nil)
    }
}


