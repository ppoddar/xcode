//
//  ServerProtocol.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 7/2/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
/*
 * An Order Management service protocol
 */
protocol ServerProtocol {
    func getServerInfo() -> ServerInfo
    func getMenu() -> Menu
    func createOrder(items:Dictionary<String,OrderItem>)
        -> Order
    func createInvoice(order:Order,
        billingAddress:Address,
        deliveryAddress:Address) -> Invoice
    func getAddresses(user:User) -> Dictionary<String,Address>
    func getUser() -> User
     
    
}
