//
//  SizedTableView.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/29/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class SizedTableView: UITableView {
    init(style:UITableView.Style) {
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
            var height:CGFloat = 0;
            for s in 0..<self.numberOfSections {
                let nRowsSection = self.numberOfRows(inSection: s)
                for r in 0..<nRowsSection {
                    height += self.rectForRow(at: IndexPath(row: r, section: s)).size.height;
                }
            }
            return CGSize(width: -1, height: height )
        }
        set {
        }
    }
}


