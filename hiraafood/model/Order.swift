import UIKit
/*
 * collection of oreder item
 */
class Order: BaseTabular<OrderItem>, Codable {
    
    
    
    typealias Model   = Order
    typealias Element = OrderItem
    var id:String
    var created:String
    
    enum CodingKeys : String,CodingKey {
        case id, created
    }
    
    
    
    required init() {
        self.id = ""
        self.created = ""
        super.init()
    
    }
    init(id:String) {
        self.id = id
        self.created = ""
        super.init()
    }
    
    override func decode(from decoder:Decoder) throws {
        NSLog("decoding Order")
        try super.decode(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id  = try container.decode(String.self, forKey: .id)
        self.created = try container.decode(String.self, forKey: .created)
    }
        
    var model: Order {get {return self}}
    
    override func addElement(_ e: Element) {
        super.addElement(e)
        total += e.price
    }
}




