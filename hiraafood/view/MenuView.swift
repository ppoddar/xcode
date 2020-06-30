import UIKit
import Foundation

class MenuView: UITableViewController {
    enum HiddenSection : String, CaseIterable {
        case hiddenAll,
        hiddenAllButFirst,
        hiddenAllButLast,
        hiddenNone
    }
    
    var menu:Menu = Menu()
    var cart:Cart = Storage.loadCart()
    lazy var section_names:Dictionary<String,String> = Dictionary<String,String>()
    lazy var hidden_sections:Set<Int> = Set<Int>()
    
    static let cellIdentifer:String = "item"
    static let sectionIdentifer:String = "section"

    /*
     * create tabular view of a menu.
     * The view is grouped by menu items in category
     * @param menu
     * @param collapsed if true all sections are collapsed
     */
    init(menu:Menu) {
        print("MenuView.init():menu=\(menu)")
        self.menu = menu
        super.init(style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = menu
        self.tableView.bounces = true
        
        
        self.tableView.backgroundColor = .red
        self.tableView.isScrollEnabled = true
        self.tableView.isSpringLoaded = true
        self.tableView.autoresizingMask = []
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(ItemCell.self, forCellReuseIdentifier: MenuView.cellIdentifer)
        self.tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MenuView.sectionIdentifer)
        self.setHeader()

        self.tableView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
        
    
    }
        
    func setupViews() {
        assert(menu.categorized_items.count > 0, "menu is empty")
        self.tableView.reloadData()
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
    
    func setHeader() {
        let label:UILabel = UIFactory.label("Menu")
        
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        
        self.tableView.tableHeaderView = label
    }
    
    
    /*
     * alwyas true
     */
    override func tableView(_ tableView: UITableView,
                   shouldSpringLoadRowAt indexPath: IndexPath,
                   with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    /*
     * height of each row is same ansd constant
     */
    override func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let h:CGFloat = self.isHidden(indexPath.section)
            ? 0 : UIConstants.ROW_HEIGHT
        NSLog("height of row at \(indexPath) \(h)")
        return h
        
    }
    /*
     * estimate height is same as actul height
     */
    override func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    /*
     * same irrespective of whether a section is hidden or not
     */
    override func tableView(_ tableView: UITableView,
            estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.LABEL_HEIGHT
    }
    
    /*
     *
     */
    func toggleSection(section:Int) {
        CATransaction.begin()
        self.tableView.beginUpdates()
        if (self.isHidden(section)) {
            showSection(section)
        } else {
            hideSection(section)
        }
        self.tableView.endUpdates()
        CATransaction.commit()
        
    }
    
    func hideSection(_ section:Int) {
        if (isHidden(section)) {return}
        let N:Int = menu.tableView(self.tableView, numberOfRowsInSection: section)
        let paths:[IndexPath] = self.sectionPaths(section, count: N)
        self.tableView.deleteRows(at: paths, with: .fade)
        // hiding this section so that menu after
        // return correct number of rows for a section
        print("insert \(section) on hidden_sections")
        self.hidden_sections.insert(section)
    }
    func showSection(_ section:Int) {
        if (!isHidden(section)) {return}
        // adding this section before so that menu wiil
        // return correct number of rows for a section
        print("remove \(section) on hidden_sections")
        self.hidden_sections.remove(section)
        let N:Int = menu.tableView(self.tableView, numberOfRowsInSection: section)
        let paths:[IndexPath] = self.sectionPaths(section, count: N)
        self.tableView.insertRows(at: paths, with: .fade)
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
    
    /*
     * View for a section header has section title and
     * a button to show/hide the section
     */
    override func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuView.sectionIdentifer)
            as? SectionHeaderView else {return UIFactory.label("section \(section)")}
        let category:String = menu.category_names[section]
        let section_name:String = section_names[category] ?? category
        let button = CollapsibleButton(owner: self, section: section)
        header.configureContents(
            title: UIFactory.label(section_name),
            button: button)
        
        
        

        //let button = CollapsibleButton(owner: self, section: section)
        //header.addSubview(button)
        // place button at right extreme
        //button.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        //button.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
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
    override func tableView(_ tableView: UITableView,
            accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //let selectedTrail = trails[indexPath.row]
        
        //if let viewController = storyboard?.instantiateViewController(identifier: "TrailViewController") as? TrailViewController {
        //    viewController.trail = selectedTrail
        //    navigationController?.pushViewController(viewController, animated: true)
        //}
        print("=========> seleceted item at \(indexPath)")
        let category:String = menu.category_names[indexPath.section]
        let items:[Item]? = menu.categorized_items[category]
        guard let item:Item = items?[indexPath.row] else {
            fatalError("expected an item at \(indexPath) but there was none")
        }
        //print("item \(String(describing: dump(item)))")
        //tableView.deselectRow(at: indexPath, animated: true)
        let orderItemController = OrderItemController(item:item, cart:cart)
        show(orderItemController, sender:self)
        //navigationController?.pushViewController(orderItemController, animated: true)
        
    }
    
    

}

/*
 * Button on section header to show/hide a section
 */
class CollapsibleButton :UIButton {
    var section:Int
    var owner:MenuView
    static let side = CGFloat(16.0)
    static let HIDDEN:String = "\u{25B6}"//H
    static let SHOWN:String  = "\u{25BC}"//S

    init(owner:MenuView, section:Int) {
        self.owner   = owner
        self.section = section
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        self.setCurrentTitle()
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggle() {
        self.owner.toggleSection(section: self.section)
        setCurrentTitle()
    }
    
    func setCurrentTitle() {
        let title = self.owner.isHidden(self.section)
        ? CollapsibleButton.HIDDEN
        : CollapsibleButton.SHOWN
        
        //print("set collapsible button title for section \(section) to title \(title) ")

        self.setTitle(title, for:.normal)
    }
}


class SectionHeaderView : UITableViewHeaderFooterView {
    
    override init(reuseIdentifier id:String?) {
        super.init(reuseIdentifier: id)
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configureContents(title:UILabel, button:CollapsibleButton) {
        contentView.addSubview(button)
        contentView.addSubview(title)

        // Center the button vertically and place it near the trailing
        // edge of the view. Constrain its width and height to 16 points.
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: CollapsibleButton.side),
            button.heightAnchor.constraint(equalToConstant:CollapsibleButton.side),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: UIConstants.LABEL_HEIGHT),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
}

    

