import Foundation

enum InvoiceItemType : String, Codable,  CaseIterable {
    case price,tax,discount
}
class InvoiceItem : Codable,HasKeyProtcol {
    var key: String
    var name:String
    var description:String
    var type:InvoiceItemType
    var amount:Double
    
    init(type:InvoiceItemType, item:OrderItem) {
        self.key =  item.sku
        self.name = item.name
        self.description = ""
        self.type = type
        switch type {
        case .price:
            self.amount = item.price
        case .tax:
            let taxRate:Double = 7.0
            self.amount = item.price * taxRate
            self.description = "tax @\(taxRate)"
        case .discount:
            let discountRate:Double = 2.0
            self.amount = item.price * discountRate
            self.description = "discounet @\(discountRate)"
                
        }
    }
    
}

