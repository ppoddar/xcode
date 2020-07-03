//
//  TestDataFactory.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit

let items:[Item] = [
    Item(sku:"101",
         name: "Vegeterian Thali",
         category: "veg",
         price: 5.99,
         desc:"Vegeterian thali is served with 3 chaptais two vegetables",
         rating: 3,
         image: "/images/item/veg-thali.jpg" ),
    Item(sku:"102",
         name: "Chicken Manchrian",
         category: "chicken",
         price: 5.99,
         desc: "",
         rating:3,
         image: "/images/item/chicken-manchurian.jpg"  ),
    Item(sku:"103",
         name: "Gobi Manchurian",
         category: "veg",
         price: 5.99,
         desc: "",
         rating:3,
         image: "/images/item/gobi-manchurian.jpg"   ),
    Item(sku:"201",
         name: "Non-vegeterian Thali",
         category: "non-veg",
         price: 5.99,
         desc: "",
         rating:3,
         image: "/images/item/non-veg-thali.jpg" ),
    Item(sku:"301",
         name: "Prawn Curry with rice",
         category: "fish",
         price: 5.99,
         desc: "",
         rating:3,
         image: "/images/item/prawn-with-rice.jpg" ),
    Item(sku:"104",name: "Potato-Cauliflower Singara",
         category: "veg",
         price: 5.99,
         desc: "",
         rating:3,
         image: "/images/item/singara.jpg" ),
    
]

let addresses = [
    "billing": Address(kind:"billing", owner:"tester",
                       line1: "1234 Hoover Street", zip: "90056",
                       line2:"", city: "Menlo Park", tips:"some tip"),
    "home":    Address(kind:"home",    owner:"tester",
                       line1: "AA 10/7", zip: "700 059",
                       line2:"line2", city: "Baguiati", tips:"some tip"),
    "office":  Address(kind:"office",  owner:"tester",
                       line1:"5926 Saint Agnes Drive", zip: "89654"),
]


class MockServer : ServerProtocol {
    
    func getServerInfo() -> ServerInfo {
        return ServerInfo()
    }
    
    func createOrder(items: Dictionary<String,
        OrderItem>) -> Order {
        let order = Order(id: "1234")
        for (_,value) in items {
            let orderItem = value
            order.addElement(orderItem)
        }
        return order
    }
    
    func createInvoice(order: Order,
                       billingAddress: Address,
                       deliveryAddress: Address) -> Invoice {
        let invoice:Invoice = Invoice()
        for (_,value) in order.items {
            let price:InvoiceItem = InvoiceItem(
                type:InvoiceItemType.price,
                item:value)
            
            let tax:InvoiceItem = InvoiceItem(
                type:InvoiceItemType.tax,
                item:value)
            let discount:InvoiceItem = InvoiceItem(
                type:InvoiceItemType.discount,
                item:value)
            
            invoice.addElement(price)
            invoice.addElement(tax)
            invoice.addElement(discount)
        }
        return invoice
    }
    
    
    func getAddresses(user:User) ->
        Dictionary<String, Address> {
            return addresses
    }
    
    func getUser() -> User {
        return User()
    }
    
    func getMenu() -> Menu {
        let menu:Menu = Menu(items: items)
        return menu
    }
    
    func getRandomItem() -> Item {
        let N:Int = items.count
        let idx = Int.random(in: 1..<N)
        return items[idx]
    }
    
    func createRandomOrder() -> Order {
        let order = Order(id: "1234")
        let N:Int = Int.random(in: 2...10)
        for _ in 0..<N {
            let item = getRandomItem()
            let units:Int = Int.random(in: 1...10)
            let orderItem:OrderItem = OrderItem(
                sku:item.sku, name:item.name,
                units:units,
                price: item.price*Double(units))
            order.addElement(orderItem)
        }
        return order
    }
    
    func getCart() -> Cart {
        let cart:Cart = Cart()
        return cart
    }
}






