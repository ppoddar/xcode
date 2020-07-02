
import UIKit

class InvoiceItemView: UITableViewCell,TableCell {
    typealias Element = InvoiceItem
    
    var item:InvoiceItem? {
        didSet {
            setupView(item)
        }
    }
    
    func setupView(_ item:InvoiceItem?) {
        guard let item = item else {
            return
        }
        self.textLabel?.text = item.name
        
        switch item.type {
        case .price :
            self.detailTextLabel?.text =
                UIFactory.amount(value: item.amount)
            break
        case .tax:
            self.detailTextLabel?.text = UIFactory.amount(value:item.amount)
            break
        case .discount:
            self.detailTextLabel?.text = UIFactory.amount(value:item.amount)
            break
        }
    }
    
}



