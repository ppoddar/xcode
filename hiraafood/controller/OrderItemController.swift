//
//  OrderFormControllerViewController.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/15/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit
class OrderItemController: UIViewController {
    var cart:Cart
    var item:Item
    var units:Counter            = Counter()
    var comment:KeyboardTextView = UIFactory.textView(placeHolder: "any instructions for the chef?")
    
    init(item:Item,  cart:Cart) {
        print("created OrderItemController with \(item)")
        self.item = item
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("========> OrderItemController viewDidLoad()")

        super.viewDidLoad()
        view.backgroundColor = .white
        self.viewRespectsSystemMinimumLayoutMargins = false
        // navigation buttons
        self.navigationItem.rightBarButtonItem  =
            UIBarButtonItem(barButtonSystemItem: .close,
                    target: self,
                    action: #selector(back))
    
    }
    override func loadView() {
        super.loadView()
        print("========> OrderItemController loadView()")

        let itemView = ItemView()
        itemView.item = self.item // must set item
        let orderButton  = UIFactory.button("Order")
        orderButton.backgroundColor = .blue
        orderButton.tintColor = .white
        UIFactory.round(orderButton)
        let existingItem:OrderItem? = cart.items[item.sku]
        units.start = existingItem?.units ?? 1

        
        // action handlers
        orderButton.addTarget(self, action: #selector(order), for:.touchUpInside)
        
        // Layout is driven via intermediate content
        // on which layput margins are honored
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(itemView)
        content.addSubview(units)
        content.addSubview(comment)
        content.addSubview(orderButton)
        self.view.addSubview(content)
        
        let safeArea = self.view.safeAreaLayoutGuide
        content.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        content.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        content.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        content.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true

        itemView.leftAnchor.constraint(equalTo: content.leftAnchor, constant:UIConstants.LEFT_MARGIN).isActive = true
        itemView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant:UIConstants.TOP_MARGIN).isActive = true
        itemView.widthAnchor.constraint(equalTo: content.widthAnchor, multiplier: 1).isActive = true
        itemView.heightAnchor.constraint(lessThanOrEqualTo: content.heightAnchor, multiplier: 0.5).isActive = true
        
        units.topAnchor.constraint(equalTo:  itemView.bottomAnchor, constant: UIConstants.LINE_HEIGHT).isActive = true
        units.leftAnchor.constraint(equalTo: itemView.leftAnchor, constant:UIConstants.LEFT_MARGIN).isActive = true
        
        comment.topAnchor.constraint(equalTo: units.bottomAnchor, constant:UIConstants.VGAP).isActive = true
        comment.leftAnchor.constraint(equalTo: itemView.leftAnchor).isActive = true
        comment.rightAnchor.constraint(equalTo: itemView.rightAnchor, constant: -UIConstants.RIGHT_MARGIN).isActive = true
        let numberOfLines:Int = 6
        let height = CGFloat(numberOfLines)*UIConstants.LINE_HEIGHT
        comment.heightAnchor.constraint(equalToConstant:height).isActive = true

        orderButton.topAnchor.constraint(equalTo:comment.bottomAnchor, constant:UIConstants.VGAP).isActive = true
        orderButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant:UIConstants.LINE_HEIGHT).isActive = true

    }
    
    
    
//
    
    
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func order() {
        cart.setItem(item:self.item,
            units: units.value,
            comment:comment.text)
        back()
    }
    
    
}




extension UIView {

    // Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    // Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true

    }
}
