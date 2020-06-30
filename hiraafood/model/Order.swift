import UIKit
/*
 * collection of oreder item
 */
struct Order: Codable {
    var id:String
    var created:String
    var total:Double
    var items:IndexedDictionary<OrderItem>
    
    enum CodingKeys : String,CodingKey {
        case id, created, total, items
    }
    
    init(id:String) {
        self.id = id
        self.created = ""
        self.total  = -1
        self.items  =  IndexedDictionary<OrderItem>()
    }
    mutating func addItem(_ item:OrderItem) {
        total += item.price
        guard var existing = items[item.sku] else {
            items.setValue(key: item.sku, value: item)
            return
        }
        existing.units += item.units
        items.setValue(key: existing.sku, value: existing)
    }
    
    mutating func decode(from decoder:Decoder) throws {
        NSLog("decoding Order")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id  = try container.decode(String.self, forKey: .id)
        self.created = try container.decode(String.self, forKey: .created)
        let totalS = try container.decode(String.self, forKey: .total)
        self.total = Double(totalS)!
        let dict:Dictionary<String,Data> = try container.decode(Dictionary.self, forKey: .items)
        self.items = IndexedDictionary<OrderItem>()
        for (key,value) in dict {
            do {
                let item = try JSONDecoder().decode(OrderItem.self, from:value)
                items.setValue(key: key, value: item)
            } catch {
                NSLog(String(describing: error))
            }
        }
    }
    
    
}




