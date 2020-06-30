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
    var units:Counter  = Counter()
    var itemView:ItemView?
    var orderButton:UIButton
    var comment:KeyboardTextView = UIFactory.textView(placeHolderText: "any instructions for the chef?")
    
    init(item:Item,  cart:Cart) {
        NSLog("created OrderItemController with \(item)")
        self.item = item
        self.cart = cart
        self.itemView = ItemView()
        self.orderButton = UIFactory.button("order")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneHeader(titleText: "Order")
        view.backgroundColor = .white
        // navigation buttons
        self.navigationItem.rightBarButtonItem  =
            UIBarButtonItem(barButtonSystemItem: .close,
                    target: self,
                    action: #selector(back))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X",
            style: .plain,
            target: self,
            action: #selector(back))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        NSLog("keyboad will show")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        NSLog("keyboard size \(keyboardSize)")
        NSLog("view origin \(self.view.frame.origin.y)")
        self.view.frame.origin.y -= keyboardSize.height
        NSLog("adjusted to \(self.view.frame.origin.y)")
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
    }
    
    override func loadView() {
        super.loadView()

        itemView?.item = self.item // must set item
        UIFactory.round(orderButton)
        let existingItem:OrderItem? = cart.items[item.sku]
        units.start = existingItem?.units ?? 1
        // action handlers
        orderButton.addTarget(self, action: #selector(order), for:.touchUpInside)
        comment.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 0.1)
        // Layout is driven via intermediate content
        // on which layput margins are honored
        self.view.addSubview(itemView!)
        self.view.addSubview(units)
        self.view.addSubview(comment)
        self.view.addSubview(orderButton)
    }
    /*
     * point at  which bounds are computed
     */
    override func viewWillLayoutSubviews() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.layoutMargins = UIEdgeInsets(
            top: safeArea.layoutFrame.origin.y,
            left:safeArea.layoutFrame.origin.x,
            bottom:safeArea.layoutFrame.height + safeArea.layoutFrame.origin.y,
            right: safeArea.layoutFrame.width + safeArea.layoutFrame.origin.x)
        
        guard let iv:ItemView = itemView else {return}
        let margins = self.view.layoutMarginsGuide
        
        iv.leftAnchor.constraint(equalTo:   margins.leftAnchor).isActive = true
        iv.topAnchor.constraint(equalTo:    margins.topAnchor).isActive = true
        iv.rightAnchor.constraint(equalTo:  safeArea.rightAnchor, constant: -margins.layoutFrame.width).isActive = true
        iv.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5).isActive = true
        
        units.leftAnchor.constraint(equalTo: margins.leftAnchor, constant:UIConstants.LEFT_MARGIN).isActive = true
        units.topAnchor.constraint(equalTo:  iv.bottomAnchor, constant: UIConstants.LINE_HEIGHT).isActive = true
        
        comment.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        comment.topAnchor.constraint(equalTo: units.bottomAnchor, constant:UIConstants.VGAP).isActive = true
        comment.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -margins.layoutFrame.width).isActive = true
        let numberOfLines:Int = 4
        let height = CGFloat(numberOfLines)*UIConstants.LINE_HEIGHT
        comment.heightAnchor.constraint(equalToConstant:height).isActive = true

        orderButton.topAnchor.constraint(equalTo:comment.bottomAnchor, constant:UIConstants.VGAP).isActive = true
        orderButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant:UIConstants.LINE_HEIGHT).isActive = true

    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func order() {
        cart.setItem(item:self.item,
            units: units.value,
            comment:comment.text)
        (presentingViewController as? OrderPageController)?.refresh()
        back()
    }
    
    
}






