import UIKit

class CartView: UITableViewController {
    static let cellIdentifier:String = "item"
    
    var cart:Cart
    init(cart:Cart) {
        print("CartView.init()")
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.tableView.register(OrderItemView.self, forCellReuseIdentifier: CartView.cellIdentifier)
        self.tableView.autoresizingMask = []
        setTableHeader()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("CartView.viewWillAppear()")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartView.cellIdentifier)
        guard let line:OrderItemView = cell as? OrderItemView
            else {return OrderItemView()}
        line.item = cart.getItemAt(indexPath.row)
        return line
    }
    
    func reloadData() {
        self.tableView.reloadData()
        self.setTableHeader()
    }
    
    func setTableHeader() {
        let imageName:String = (self.cart.items.count>0)
        ? "cart.fill" : "cart.fill.badge.minus"
        let caption = (self.cart.items.count>0)
        ? "cart" : "empty"
        let title:UILabel = UIFactory.imageLabel(
            image: imageName, caption: caption)
        title.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.tableHeaderView = title
        self.tableView.tableHeaderView?.centerXAnchor.constraint(
            equalTo: self.tableView.centerXAnchor).isActive = true
    }
}


