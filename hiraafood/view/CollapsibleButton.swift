//
//  CollapsibleButton.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/26/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

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
        addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleSection() {
        NSLog("********** YAHOO *********** toggle \(section)")
        self.owner.toggleSection(section: self.section)
        setCurrentTitle()
    }
    
    func setCurrentTitle() {
        let title = self.owner.isHidden(self.section)
        ? CollapsibleButton.HIDDEN
        : CollapsibleButton.SHOWN
        
        NSLog("set collapsible button title for section \(section) to title \(title) ")

        self.setTitle(title, for:.normal)
    }
}
