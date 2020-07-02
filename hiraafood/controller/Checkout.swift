//
//  Checkout.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit
//import SwiftyJSON

class CheckoutViewController: UIViewController {
    var cartView:CartView
    var checkout:UIButton
    var back:UIButton
    init(cart:Cart) {
        self.cartView = CartView(cart: cart)
        self.checkout = UIFactory.button("proceed to checkout")
        self.back     = UIFactory.button("continue shopping")
        super.init(nibName: nil, bundle: nil)
        back.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        checkout.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewController(cartView)
        self.view.addSubview(checkout)
        self.view.addSubview(back)
    }
    
    override func viewWillLayoutSubviews() {
        cartView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        cartView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        cartView.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        cartView.view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        checkout.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        back.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        checkout.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        back.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func createOrder() {
        NSLog("----------- createOrder ------------ ")
        let url:String = "/order/?uid=tester"
        let payload:Data? = cartView.modelObj.payload
        Server.singleton.post(
            url:url,
            // payload must be Array or Dictionary
        payload:payload) {result in
            switch (result) {
            case .success:
                do {
                    let json:String = try String(data:result.get(), encoding:.utf8)!
                    NSLog("--------- resposne POST /order/?uid=tester-------")
                    NSLog(json)
                    let order:Order = try JSONDecoder().decode(Order.self, from: json.data(using: .utf8)!)
                    NSLog("received create order response \(order)")
                    Server.singleton.get(url: "/user/addresses/?uid=tester") { result in
                        do {
                            switch(result) {
                            case .success:
                                let json:String = try String(data:result.get(), encoding:.utf8)!
                                let addresses:Dictionary<String,Address> = try JSONDecoder().decode(Dictionary<String,Address>.self, from: json.data(using: .utf8)!)
                                DispatchQueue.main.async {
                                    let page = DeliveryController(order:order, addresses:addresses)
                                    self.show(page, sender: self)
                                }
                                case .failure:
                                self.alert(title:"JSON decoding error", message: "String(describing: error)")
                            }
                        } catch {
                            self.alert(title: "error fetching address", message: String(describing: error))
                        }
                    }
                } catch {
                    self.alert(title: "error creating Order", message: String(describing: error))
                }
            case .failure (let error):
                self.alert(title: "", message:String(describing:error))
            }
        }
    
    }
    
    
}
