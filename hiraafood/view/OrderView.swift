//
//  OrderView.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/25/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class OrderView: UITableView,UITableViewDelegate,UITableViewDataSource {
     static let cellIdentifer:String = "item"
     
     init(order:Order) {
        self.order = order
        super.init(frame: .zero, style:UITableView.Style.grouped)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     var order:Order {
         didSet {
             dataSource = self
             delegate   = self
             register(OrderItemView.self, forCellReuseIdentifier: OrderView.cellIdentifer)
         
             self.tableHeaderView = createHeader()
             self.tableFooterView = createFooter()
         }

     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.order.items.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: OrderView.cellIdentifer)
         as? OrderItemView
         cell?.item = order.items[indexPath.row]
         return cell!
     }
     
     func createHeader() -> UIView? {
         let header = UIFactory.label(order.id)
         return header
     }

     func createFooter() -> UIView? {
         let footer = UIFactory.label(UIFactory.amount(order.total))
         return footer
     }

}
