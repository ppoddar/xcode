import Foundation
/*
 * an ietms and number of units ordered
 */
class OrderItem : Codable,Hashable,Equatable,HasKeyProtcol,CustomStringConvertible {
    var sku:String
    var name:String
    var units:Int
    var comment:String = ""
    var price:Double  // nil implies not priced
    
    static func == (lhs: OrderItem, rhs: OrderItem) -> Bool {
        return lhs.sku == rhs.sku
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(sku)
    }
    
    var description:String {
        get {
            return "\(self.sku):\(self.name) (\(self.units)) \(self.price) "
        }
    }
    convenience init() {
        self.init(sku:"0", name:"not set", units:-1, price:-1)
    }
    
    init(sku:String, name:String, units:Int, price:Double, comment:String?="") {
        self.sku = sku
        self.name = name
        self.units = units
        self.price = price
        self.comment = comment!
    }
    convenience init(item:Item, units:Int, comment:String = "") {
        self.init(sku:item.sku, name:item.name, units:units,
                  price:item.price*Double(units),
                  comment:comment)
    }
    
    var key: String {
        get { return sku}
    }
    
    
    
 /*
    mutating func decode(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sku  = try container.decode(String.self, forKey: .sku)
        self.name = try container.decode(String.self, forKey: .name)
        self.comment = try container.decode(String.self, forKey: .comment)

        let unitsS = try container.decode(String.self, forKey: .units)
        let priceS = try container.decode(String.self, forKey: .price)
        self.price = Double(priceS)!
        self.units = Int(unitsS)!

    }
 */
}

