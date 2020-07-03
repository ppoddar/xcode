//
//  RandomStart.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 7/2/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit

enum ControllerUnderTest : String, CaseIterable {
    case welcome,
        item,
        order,
        delivery,
        payment,
        checkout,
        address
}


class RandomStart {
    let server:MockServer = MockServer()
    
    func randomController(_ c:ControllerUnderTest)
        -> UIViewController {
        switch c {
        case .welcome:
            return WelcomeViewController()
        case .item:
            return OrderItemController(item:server.getRandomItem(), cart:server.getCart())
        case .order:
            return MenuController(menu: server.getMenu())
        case .checkout:
            return CheckoutViewController(cart: server.getCart())
        case .payment:
            let order = server.createRandomOrder()
            let addresses = server.getAddresses(user:User())
            let bill  = server.createInvoice(
                order: order,
                billingAddress:addresses["billing"]!,
                deliveryAddress:addresses["delivery"]!)
            return PaymentController(invoice: bill)
        case .delivery:
            return DeliveryController(
                order: server.createRandomOrder(),
                addresses:server.getAddresses(user:User()))
        case .address:
            return AddressSelectionViewController(
                addresses: server.getAddresses(user:User()))
        }
    }}
