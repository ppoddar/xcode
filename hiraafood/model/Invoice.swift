import Foundation

let NOT_SET:String = "NOT SET"
class Invoice: Codable {
    var id:String
    var total:Double
    var status:String
    var createdAt:String
    var payorder:String
    var items:[InvoiceItem]
    
    init() {
        id        = NOT_SET
        total     = 0.0
        status    = NOT_SET
        createdAt = NOT_SET
        payorder  = NOT_SET
        items     = [InvoiceItem]()
    }
}
