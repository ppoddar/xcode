//
//  OpenItemOrderFormButton.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class OpenItemOrderFormButton: UIButton {

    var item:Item
    var cart:Cart
    var controller:UIViewController
    init(item:Item, cart:Cart, controller:UIViewController) {
        self.item = item
        self.cart = cart
        self.controller = controller
        super.init(frame:.zero)
        
        self.setTitle(">", for: .normal)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func openOrderForm () {
        let dialog = OrderItemController(item: item, cart: cart)
        controller.show(dialog, sender: self)
    }
   
    
}
