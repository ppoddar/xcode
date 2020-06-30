import UIKit

/*
 * Shows an invoice (bill).
 * Tablular view of inventory items.
 * Each item is rendered as per its type
 * Header and Footer is configured
 */
class InvoiceView: UITableView,UITableViewDelegate,UITableViewDataSource {
    static let cellIdentifer:String = "item"
    
    init(invoice:Invoice) {
       self.invoice = invoice
       super.init(frame: .zero, style:UITableView.Style.grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var invoice:Invoice? {
        didSet {
            dataSource = self
            delegate   = self
            register(InvoiceItemView.self, forCellReuseIdentifier: InvoiceView.cellIdentifer)
        
            self.tableHeaderView = createHeader()
            self.tableFooterView = createFooter()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.invoice?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceView.cellIdentifer)
        as? InvoiceItemView
        return cell!
    }
    
    
    func createHeader() -> UIView? {
        let header = UIFactory.label(invoice?.id ?? "")
        return header
    }

    func createFooter() -> UIView? {
        let footer = UIFactory.label(UIFactory.amount(invoice?.total ?? 0))
        return footer
    }
}
