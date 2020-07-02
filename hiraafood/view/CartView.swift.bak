import UIKit
import Foundation

/*
 * Control tabular view of a sectioned menu
 *
 */
class CartView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var cart:Cart
    static let cellIdentifer:String    = "item"

    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(cart:Cart) {
        self.cart = cart
        super.init(nibName:nil, bundle:nil)
        
        self.view = UITableView(frame: .zero, style: .plain)
        
        guard let table = self.view as? UITableView
            else {return}
        self.configureTableView(table:table)
        table.allowsSelection = false
        self.view.backgroundColor = .white
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        //self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
        self.view.clipsToBounds = true
    }
    
    func configureTableView(table:UITableView) {
        table.delegate   = self
        table.dataSource = self
        table.bounces    = true
        table.isScrollEnabled = true
        table.isSpringLoaded = true
        table.register(OrderItemView.self, forCellReuseIdentifier: MenuView.cellIdentifer)
        self.setHeader(table: table)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("CartView.viewWillAppear() ")
        guard let table = self.view as? UITableView
            else {return}
        table.reloadData()
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setHeader(table:UITableView) {
        let label:UILabel = UIFactory.label("Cart")
        
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        
        table.tableHeaderView = label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empty = OrderItemView()
        NSLog("getting item cell for \(indexPath)")
        let cell = tableView.dequeueReusableCell(withIdentifier: CartView.cellIdentifer) as? OrderItemView
        guard let c = cell else {return empty}
        let item = cart.items[indexPath.row]
        c.item = item
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
        let h:CGFloat = UIConstants.ROW_HEIGHT
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











