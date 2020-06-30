import Foundation
import UIKit

class Menu: NSObject, UITableViewDataSource {
    var categorized_items:Dictionary<String,[Item]> {
        get {
            return Dictionary(grouping: items,
                by: {return $0.category.lowercased()})
            
        }
    }
    
    var category_names:[String] {
        get {
            return categorized_items.keys.sorted()
        }
    }
    
    var items:[Item] = [Item]()
    var viewDelegate:MenuView?
    
    
    
    /*
     * Returns number of sections
     */
    public func numberOfSections(in tableView: UITableView) -> Int {
        print("Menu.numberOfSections: \(category_names.count)")
        return self.category_names.count
    }
    /*
     * Configures a table cell by an item
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ItemCell = tableView.dequeueReusableCell(
            withIdentifier: MenuView.cellIdentifer,
            for: indexPath)
            as? ItemCell else {
                return ItemCell()
        }
        let category = category_names[indexPath.section]
        let item = categorized_items[category]?[indexPath.row]
        cell.item = item! // will configure Itemcell
        return cell
    }
   
    /*
     * Returns number of rows in a section.
     * This number varies if a section is hidden or not
     * For hidden section it always returns 0
     * Else is returns items in given section which is
     * same as items in that category
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hidden:Bool = viewDelegate?.isHidden(section)
            else {return 0}
        if (hidden) {
            return 0
        }
        let category    = category_names[section]
        guard let items = categorized_items[category]
        else {
            print("WARN: found no items for category \(category) section \(section) ")
            return 0
        }
        return items.count
    }
    
}

