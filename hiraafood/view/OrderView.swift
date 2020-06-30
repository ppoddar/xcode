import UIKit
import Foundation

/*
 * Control tabular view of a sectioned menu
 *
 */
class OrderView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var order:Order
    static let cellIdentifer:String    = "item"

    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(order:Order) {
        self.order = order
        super.init(nibName:nil, bundle:nil)
        
        self.view = SizedTableView(style: UITableView.Style.plain)
            
        guard let table = self.view as? SizedTableView
            else {return}
        self.configureTableView(table:table)
        self.view.backgroundColor = .white
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        //self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
        self.view.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func configureTableView(table:UITableView) {
        table.allowsSelection = false
        table.delegate   = self
        table.dataSource = self
        table.bounces    = true
        table.isScrollEnabled = true
        table.isSpringLoaded = true
        table.register(OrderItemView.self, forCellReuseIdentifier: OrderView.cellIdentifer)
        self.setHeader(table: table)
    }
     
     
    func setHeader(table:UITableView) {
        let label:UILabel = UIFactory.label("Order")
        
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        
        table.tableHeaderView = label
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("OrderView.viewDidAppear() ")
        guard let table = self.view as? SizedTableView
            else {return}
        table.reloadData()
    }
    
    /*
     * Return one more than items
     * The last row would show total
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empty = OrderItemView()
        let cell = tableView.dequeueReusableCell(withIdentifier: CartView.cellIdentifer) as? OrderItemView
        guard let c = cell else {return empty}
        if indexPath.row == order.items.count {
            NSLog("=======> getting item cell for total \(indexPath)")
            c.total = order.total
        } else {
            let item = order.items[indexPath.row]
            c.item = item
        }
        return c
    }
    /*
     * alwyas true
     */
    func tableView(_ tableView: UITableView,
                   shouldSpringLoadRowAt indexPath: IndexPath,
                   with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    /*
     * height of each row is same ansd constant
     */
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h:CGFloat = UIConstants.ROW_HEIGHT/4
        return h
        
    }
    /*
     * estimate height is same as actul height
     */
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
}











