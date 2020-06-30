import Foundation
class InvoiceItem : Codable {
    
    enum InvoiceItemType : String, Codable,  CaseIterable {
        case price,tax,discount
    }
    
    var name:String
    var description:String
    var type:InvoiceItemType
    var amount:Double
}

