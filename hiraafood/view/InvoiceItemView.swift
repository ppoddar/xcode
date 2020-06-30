
import UIKit

class InvoiceItemView: UITableViewCell {
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier:InvoiceView.cellIdentifer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            self.detailTextLabel?.text = UIFactory.amount(item.amount)
            break
        case .tax:
            self.detailTextLabel?.text = UIFactory.amount(item.amount)
            break
        case .discount:
            self.detailTextLabel?.text = UIFactory.amount(item.amount)
            break
        }
    }
    
    
}



