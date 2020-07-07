import UIKit
import Foundation

/*
 * Control tabular view of a sectioned menu
 *
 */
class InvoiceViewController:GenericTableViewController<Invoice,InvoiceItemView> {
    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(invoice:Invoice) {
        super.init(model: invoice)
         
        self.view = SizedTableView(style: UITableView.Style.plain)
            
        self.configureTableView()
        self.view.backgroundColor = .white
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        //self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
        self.view.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func reloadInputViews() {
        NSLog("\(type(of:self)).reloadInputViews ")
        guard let table = self.view as? SizedTableView
            else {return}
        table.reloadData()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("OrderView.viewDidAppear() ")
        guard let table = self.view as? SizedTableView
            else {return}
        table.reloadData()
    }
    
}











