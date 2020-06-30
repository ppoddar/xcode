import UIKit
/*
 * collection of oreder item
 */
struct Order: Codable {
    var id:String
    var createdAt:String
    var total:Double
    var items:[OrderItem] =  [OrderItem]()
//
//    public func hash(into hasher: inout Hasher) {
//         hasher.combine(id.hashValue)
//    }
//    static func == (lhs: Order, rhs: Order) -> Bool {
//        return lhs.id == rhs.id
//    }
//
    
}
