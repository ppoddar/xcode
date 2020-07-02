//
//  OrderItemView.swift
//  hiraafood5
//
//  Created by Pinaki Poddar on 6/23/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class OrderItemView: UITableViewCell,TableCell {
    typealias Element = OrderItem
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:UITableViewCell.CellStyle.value1, reuseIdentifier:reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var item:OrderItem? {
        didSet {
            guard let i = item else {return}
            setupView(i)
        }
    }
    
    func setupView(_ item:OrderItem?) {
        guard let i = item else {return}
        NSLog("OrderItemView.setupView with item \(String(describing: item))")
        var title = i.name
        if i.units > 1 {
            title +=  " (\(i.units))"
        }
        self.textLabel?.text = title
        self.detailTextLabel?.text = UIFactory.amount(value:i.price)
    }
    
    
}
