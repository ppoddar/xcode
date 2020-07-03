import Foundation
/*
 * Set of OrderItem indexed by item sku
 * The keys are ordered by order of insertion
 */
class Cart: BaseTabular<OrderItem>, Codable {
    func addItem(item:Item, units:Int, comment:String) {
        let existing = self[item.sku]
        var itemToAdd:OrderItem
        let price:Double = item.price * Double(units)
        if existing == nil {
            itemToAdd = OrderItem(sku: item.sku, name: item.name,
                units: units,
                price: price)
        } else {
            itemToAdd = existing!
            itemToAdd.price   = price
            itemToAdd.units   = units
            itemToAdd.comment = comment
        }
        addElement(itemToAdd)
        
    }
    
    
    var model:Cart { get {return self}}
    
    override func addElement(_ e: Element) {
        super.addElement(e)
        total += e.price
    }
    
    var payload:Data? {
        get {
            return JSONHelper()
                .jsonFromDict(type:OrderItem.self,
                        dict:_elements)
        }
    }


}


