import Foundation

let NOT_SET:String = "NOT SET"

class Invoice: BaseTabular<InvoiceItem>, Codable {
    typealias Element = InvoiceItem
    
    var id:String
    var status:String
    var createdAt:String
    var payorder:String
    
    var model: Invoice {get {return self}}
    
    
    required init() {
        id        = NOT_SET
        status    = NOT_SET
        createdAt = NOT_SET
        payorder  = NOT_SET
        super.init()
    }
    
    override func addElement(_ e: Element) {
        super.addElement(e)
        total = e.amount
    }

}
