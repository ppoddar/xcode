//
//  RandomStart.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 7/2/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit
class RandomStart {
    let server:MockServer = MockServer()
    
    func randomController(_ c:ControllerUnderTest)
        -> UIViewController {
        switch c {
        case .welcome:
            return WelcomeViewController()
        case .order:
            return OrderPageController(menu: server.getMenu())
        case .checkout:
            return CheckoutViewController(cart: server.getCart())
        case .payment:
            let order = server.createRandomOrder()
            let bill  = server.createInvoice(
                order: order,
                billingAddress:server.getAddresses()["billing"]!,
                deliveryAddress:server.getAddresses()["delivery"]!)
            return PaymentController(invoice: bill)
        case .delivery:
            return DeliveryController(order: server.createRandomOrder(), addresses:server.getAddresses())
        case .address:
            return AddressSelectionViewController(addresses: server.getAddresses())
        }
    }}
