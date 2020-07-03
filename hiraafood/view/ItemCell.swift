//
//  ItemCell.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    var item:Item? {
        didSet {
            setupView(item)
        }
    }
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier:reuseIdentifier)
        accessoryType = .disclosureIndicator
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(_ item:Item?) {
        guard let item = item else {
            return
        }
        self.textLabel?.text = item.name
        self.detailTextLabel?.text = item.category
        let image = ImageLibrary().getItemImage(name:item.image)
        self.imageView?.image = image
    }
 
}
