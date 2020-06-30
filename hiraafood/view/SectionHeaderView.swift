//
//  SectionHeaderView.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/26/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class SectionHeaderView : UITableViewHeaderFooterView {
    var section:Int
    var menuView:MenuView?
    
    override init(reuseIdentifier  id:String?) {
        self.section = 0
        super.init(reuseIdentifier:MenuView.sectionIdentifer)
        isUserInteractionEnabled = true
        let action:UIGestureRecognizer
            = UITapGestureRecognizer(
                target: self,
                action: #selector(toggleSection))
        addGestureRecognizer(action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect { get {
        return super.frame
    }
    set { if newValue.width == 0 {return }
        super.frame = newValue
        }
    }
    
    func configure(text:String) {
        
        print("SectionHeaderView.configure() \(text)")
        textLabel?.text = text
        textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        guard let label = contentView as? UITableViewHeaderFooterContentView else {
//            print("** content view is not a label but of type \(type(of:contentView))")
//            return
//        }
//        label.text = text
    }
    
    
    
    
    @objc func toggleSection() {
        if (menuView == nil) {
            print("** can not toggle section, because no controoler is set")
        }
        menuView?.toggleSection(section: section)
    }
}
/*
 @objc func singleTap(tapGestureRecognizer: UITapGestureRecognizer) {
 print("========= Y A H O O =========")
 
 guard let table = superview as? UITableView else {return}
 
 // detect the tapped view
 let loc = tapGestureRecognizer.location(in: table)
 
 
 let N:Int = menu.category_names.count
 for i in 0..<N {
 guard let k = table.headerView(forSection: i) else {
 return
 }
 if k.frame.contains(loc) {
 print("tapped \(k) section")
 do {
 // header was tapped
 self.toggleSection(section: i)
 }
 }
 }
 }
 */

/*
 //    override var contentView: UIView {
 //        get {
 //            let result = UILabel()
 //            result.text = label
 //            result.font = UIFont.boldSystemFont(ofSize: 16)
 //            return result
 //        }
 //
 //    }
 
 */

