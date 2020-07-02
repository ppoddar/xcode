//
//  TestViewController.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

/*
 * A controller for testing
 */
class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let c:ControllerUnderTest = .address
        let main:UIViewController
        
        switch c {
        case .welcome:
            main = WelcomeViewController()
        case .order:
            main = OrderPageController(menu: TestDataFactory.getMenu())
        case .checkout:
            main = CheckoutViewController(cart: TestDataFactory.getCart())
        case .payment:
            let order:Order = TestDataFactory.getOrder();
            let bill:Invoice = TestDataFactory.getInvoice(order: order)
            main = PaymentController(invoice: bill,
                                     billingAddress: TestDataFactory.getAddress(key: "billing"),
                                     deliveryAddress: TestDataFactory.getAddress(key: "delivery"))
        case .delivery:
            main = DeliveryController(
                order: TestDataFactory.getOrder(),
                addresses: TestDataFactory.getAddresses())
        case .address:
            main = AddressSelectionViewController(addresses:TestDataFactory.getAddresses())
        }
        show(main, sender: self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
