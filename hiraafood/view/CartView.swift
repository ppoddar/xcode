import UIKit
import Foundation

/*
 * Control tabular view of a sectioned menu
 *
 */
class CartView: GenericTableViewController<Cart,OrderItemView> {
    typealias Model    = Cart
    typealias Element  = OrderItem
    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(cart:Cart) {
        super.init(model:cart)
        self.asTable.tableHeaderView = createHeader(title: "Cart")
        self.asTable.tableFooterView = createFooter(total: cart.total)
        self.configureTableView()
        self.view.backgroundColor = .white
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.clipsToBounds = true
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
}











