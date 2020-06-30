import Foundation
import UIKit

class Menu: NSObject {
     var categorized_items:Dictionary<String,[Item]>
     var category_names:[String]

    init(items:[Item]) {
        categorized_items =
             Dictionary(grouping: items,
                by: {return $0.category.lowercased()})
        category_names = categorized_items.keys.sorted()
        super.init()
    }
    
    
}



