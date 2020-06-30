import UIKit
import Foundation

/*
 * Control tabular view of a sectioned menu
 *
 */
class MenuView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    enum HiddenSection : String, CaseIterable {
        case hiddenAll,
        hiddenAllButFirst,
        hiddenAllButLast,
        hiddenNone
    }
    
    var menu:Menu
    var cart:Cart
    //var view:UITableView
    lazy var hidden_sections:Set<Int> = Set<Int>()
    
    static let cellIdentifer:String    = "item"
    static let sectionIdentifer:String = "section"

    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(menu:Menu, cart:Cart) {
        self.menu = menu
        self.cart = cart
        //let frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        super.init(nibName:nil, bundle:nil)
        
        self.view = UITableView(frame: .zero, style: .grouped)

        hidden_sections = MenuView.initHiddenSection(sectionCount: menu.category_names.count, style: MenuView.HiddenSection.hiddenAllButFirst)
        print("Hidden section \(hidden_sections)")
        
        guard let table = self.view as? UITableView
            else {return}
        self.configureTableView(table:table)
        
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
        table.register(ItemCell.self, forCellReuseIdentifier: MenuView.cellIdentifer)
        table.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MenuView.sectionIdentifer)
        self.setHeader(table: table)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        print("MenuViewController.viewWillAppear() ")
        guard let table = self.view as? UITableView
            else {return}
        table.reloadData()
        super.viewWillAppear(animated)
    }
    
   
    static func initHiddenSection (sectionCount:Int, style:HiddenSection) -> Set<Int> {
        var hidden:Set<Int> = Set<Int>(0..<sectionCount)
        switch style {
        case .hiddenAll:
            return hidden
        case .hiddenAllButLast:
            hidden.remove(sectionCount-1)
            return hidden
        case .hiddenAllButFirst:
            hidden.remove(0)
            return hidden
        case .hiddenNone:
            return Set<Int>()
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setHeader(table:UITableView) {
        let label:UILabel = UIFactory.label("Menu")
        
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        label.frame = CGRect(x:0,y:0, width:self.view.frame.width, height:UIConstants.LINE_HEIGHT)
        label.bounds = CGRect(x:0,y:0, width:100, height:UIConstants.LINE_HEIGHT)
        table.tableHeaderView = label
        
        table.tableHeaderView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        table.tableHeaderView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.category_names.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isHidden(section)) {
            print("section \(section) is hidden. NUmber of rows = 0")
            return 0
        }
        let category = menu.category_names[section]
        guard let items = menu.categorized_items[category] else {return 0}
        print("section \(section) number of rows = \(items.count)")
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empty = ItemCell()
        print("getting item cell for \(indexPath)")
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuView.cellIdentifer) as? ItemCell
        guard let c = cell else {return empty}
        let category = menu.category_names[indexPath.section]
        guard let items = menu.categorized_items[category] else {return empty}
        let item = items[indexPath.row]
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
        
        if (isHidden(indexPath.section)) {
            print("height of row at \(indexPath) because section is hiiden")
            return 0
        }
        let h:CGFloat = UIConstants.ROW_HEIGHT
        //print("height of row at \(indexPath) \(h)")
        return h
        
    }
    /*
     * estimate height is same as actul height
     */
     func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    /*
     * same irrespective of whether a section is hidden or not
     */
     func tableView(_ tableView: UITableView,
            heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.LABEL_HEIGHT
    }
    
    /*
     *
     */
    @objc func toggleSection(section:Int) {
        //print("------------- YAHOO \(section) ------------------ ")
        guard let table = self.view as? UITableView
            else {return}
        
        
        CATransaction.begin()
        table.beginUpdates()
        if (self.isHidden(section)) {
            showSection(section)
        } else {
            hideSection(section)
        }
        table.endUpdates()
        CATransaction.commit()
        
    }
    
    func hideSection(_ section:Int) {
        print("hide section \(section)")

        if (isHidden(section)) {
            //print("section \(section) is already hidden. returning")
            return
            
        }
        guard let table = self.view as? UITableView
            else {return}
        
        
        let N:Int = self.tableView(table, numberOfRowsInSection: section)
        let paths:[IndexPath] = self.sectionPaths(section, count: N)
        table.deleteRows(at: paths, with: .fade)
        // hiding this section so that menu after
        // return correct number of rows for a section
        //print("insert \(section) on hidden_sections")
        self.hidden_sections.insert(section)
    }
    func showSection(_ section:Int) {
        print("show section \(section)")
        if (!isHidden(section)) {
            //print("section \(section) is already visible. returning")
            return
        }
       guard let table = self.view as? UITableView
           else {return}
            // adding this section before so that menu wiil
        // return correct number of rows for a section
        print("remove \(section) on hidden_sections")
        self.hidden_sections.remove(section)
        let N:Int = self.tableView(table, numberOfRowsInSection: section)
        let paths:[IndexPath] = self.sectionPaths(section, count: N)
        table.insertRows(at: paths, with: .fade)
        let M:Int = self.menu.category_names.count
        for i in 0..<M {
            if (i == section) {continue}
            if (isHidden(i)) {continue}
            hideSection(i)
        }
        
    }
    
    /*
     * all index paths for a section
     * @param section index
     * @param count number of rows in that section
     */
    func sectionPaths(_ section:Int, count:Int) -> [IndexPath] {
        var paths:[IndexPath] = [IndexPath](repeating: IndexPath(), count: count)
        for i in 0..<count {
            let path = IndexPath(row:i, section:section)
            paths[i] = path
        }
        return paths
    }
//    func tableView(_ tableView: UITableView,
//                   titleForHeaderInSection section: Int) -> String? {
//        return menu.category_names[section]
//    }
    
    /*
     * View for a section header has section title and
     * a button to show/hide the section
     */
    
    
     func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
        
        print("===================================")
        print("viewForHeaderInSection \(section)")
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuView.sectionIdentifer)
            as? SectionHeaderView
            else {
                print("*** reusable section not found for \(section)")
                return SectionHeaderView()
            }
        header.section = section
        header.menuView = self
        header.configure(text: menu.category_names[section])
        return header
    }
       /*
     * affirms if section is currently hidden
     */
    func isHidden(_ section:Int) -> Bool {
        let r = hidden_sections.contains(section)
        //print ("section \(section) is now  hidden ? \(r)")
        return r
    }
    
    
    /*
     * -------------- Row Selection
     */
    func tableView(_ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath) {
        print("=========> seleceted item at \(indexPath)")
        let category:String = menu.category_names[indexPath.section]
        let items:[Item]? = menu.categorized_items[category]
        guard let item:Item = items?[indexPath.row] else {
            fatalError("expected an item at \(indexPath) but there was none")
        }
        openSelectedItem(item)
    }
    
    func openSelectedItem(_ item:Item) {
        
        //print("item \(String(describing: dump(item)))")
        //tableView.deselectRow(at: indexPath, animated: true)
        let orderItemController = OrderItemController(item:item, cart:cart)
        //show(orderItemController, sender:self)
        
        //self.modalPresentationStyle = .fullScreen
        //self.present(orderItemController, animated: true)
        show(orderItemController, sender: self)
    }
}




   
   
     


    

