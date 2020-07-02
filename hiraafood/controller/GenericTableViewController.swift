import UIKit
import Foundation

/*
 * Control tabular view of row orieneted data.
 *
 * Generic Type infromation:
 * M - Tabular
 * E - TableCell & UITableViewCell
 *
 */
class GenericTableViewController<
    M : Tabular,        // tabular data to be displayed
    E : TableCell & UITableViewCell // view of each row
    > :
    UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    enum RowHeightStyle : String,CaseIterable {
        case compact, nornmal
    }
    
    var modelObj:M
    let allowsSelection:Bool = false
    let rowHeightStyle:RowHeightStyle? = .compact
    let cellStyle:UITableViewCell.CellStyle?
    let cellIdentifer:String = "item"

    /*
     * create tabular view of a model.
     * The view is grouped by menu items in category
     * @param model
     * @param style UITableView.Style
     * @param collapsed if true all sections are collapsed
     */
    init(model : M,
        style:UITableView.Style = .plain,
        cellStyle:UITableViewCell.CellStyle = .value1) {
        self.modelObj = model
        self.cellStyle = cellStyle
        super.init(nibName:nil, bundle:nil)
        let table = SizedTableView(style: style)
        let rowHeight = self.tableView(table, heightForRowAt: IndexPath(row: 0, section: 0))
        table.height  = CGFloat(model.numberOfElements + 4) * rowHeight
        
        self.view = table
        self.configureTableView()

        self.view.backgroundColor = .white
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func reloadInputViews() {
        NSLog("\(type(of:self)).reloadInputViews ")
        guard let table = self.view as? UITableView
            else {return}
        table.reloadData()
    }
    
    final func configureTableView() {
        let table = self.asTable
        table.delegate   = self
        table.dataSource = self
        table.bounces    = true
        table.allowsSelection = allowsSelection
        table.isScrollEnabled = true
        table.isSpringLoaded = true
        table.register(E.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    final var asTable:UITableView {
        get {
            return (self.view as! UITableView)
        }
    }
    
    func setHeader(_ view:UIView) {
        self.asTable.tableHeaderView = view
        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setFooter(_ view:UIView) {
        self.asTable.tableFooterView = view
    }
    
    func createHeader(title:String) -> UIView {
        let label:UILabel = UIFactory.label(title)
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        label.frame = CGRect(x:0,y:0, width:self.view.frame.width, height:UIConstants.LABEL_HEIGHT)
        return label
    }
    
    func createFooter(total:Double) -> UIView {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "")
        cell.textLabel?.text       = "Total"
        cell.detailTextLabel?.text = UIFactory.amount(value:total)
        
        return cell
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("OrderView.viewDidAppear() ")
        (self.view as? UITableView)?.reloadData()
    }
    
    /*
     * Return one more than items
     * The last row would show total
     */
    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("\(type(of:self)) has \(modelObj.numberOfElements) items")
        return modelObj.numberOfElements
    }
    
    final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("\(type(of:tableView)) getting row at \(indexPath)")
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? E
        if (cell == nil) {
            cell = E.init(style:cellStyle!, reuseIdentifier: cellIdentifer)
        }
        guard var c = cell else {fatalError()}
        let item = modelObj[indexPath.row]
        c.item = (item as!  E.Element)
        
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
     * height of each row is same and constant
     */
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        var divisor:CGFloat = 1.0
        if (rowHeightStyle == .compact) {divisor = 4.0}
        let h:CGFloat = UIConstants.ROW_HEIGHT/divisor
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











