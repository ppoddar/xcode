import Foundation
/*
 * an ietms and number of units ordered
 */
struct OrderItem : Codable,Hashable,Equatable {
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

