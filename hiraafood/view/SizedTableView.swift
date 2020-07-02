//
//  SizedTableView.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/29/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class SizedTableView: UITableView {
    var height:CGFloat
    init(style:UITableView.Style) {
        self.height = 64
        super.init(frame: .zero, style:style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    override var intrinsicContentSize: CGSize {
        get {
            let size = CGSize(width: UIScreen.main.bounds.width, height: height  )
            NSLog("\(type(of:self)).intrinsicContentSize=\(size)")
            return size
        }
    }
    /*
    override var intrinsicContentSize: CGSize {
        get {
            NSLog("\(type(of:self)).intrinsicContentSize")
            var height:CGFloat = 0;
            let nSection:Int = self.numberOfSections
            for s in 0..<nSection {
                let nRowsSection = self.numberOfRows(inSection: s)
                for r in 0..<nRowsSection {
                    let h = self.delegate?.tableView?(self, heightForRowAt: IndexPath(item:r, section: s)) ?? 0
                    height += h
                    //    self.rectForRow(at: IndexPath(row: r, section: s)).size.height;
                }
            }
            let size = CGSize(width: UIScreen.main.bounds.width, height: height )
            NSLog("\(type(of:self)).intrinsicContentSize=\(size)")
            return size
            
        }
        set {
        }
    }
    */
}


