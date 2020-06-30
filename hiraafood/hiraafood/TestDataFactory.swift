//
//  TestDataFactory.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit

enum ControllerUnderTest : String, CaseIterable {
    case welcome, address, order, payment, checkout
}

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
struct TestDataFactory {
    static func getMenu() -> Menu {
        let menu:Menu = Menu()
        menu.items = items
        return menu
    }
    static func randomItem() -> Item {
        let N:Int = items.count
        let idx = Int.random(in: 1..<N)
        return items[idx]
    }
    
    static func getOrder() -> Order {
        var order = Order(id: "1234")
        let N:Int = Int.random(in: 2...10)
        for _ in 0..<N {
            let item = TestDataFactory.randomItem()
            let units:Int = Int.random(in: 1...10)
            let orderItem:OrderItem = OrderItem(
                sku:item.sku, name:item.name,
                units:units,
                price: item.price*Double(units))
            order.addItem(orderItem)
        }
        return order
    }
    
    static func getAddress(key:String) -> Address {
        return addresses[key]!
    }
    
    static func getAddresses() -> Dictionary<String,Address> {
        return addresses
    }
    
    static func getCart() -> Cart {
        let cart:Cart = Cart()
        return cart
    }
    
    static func viewController(_ c:ControllerUnderTest) -> UIViewController {
        switch c {
         case .welcome:
             return WelcomeViewController()
         case .order:
             return OrderPageController()
         case .checkout:
             return CheckoutViewController(cart: TestDataFactory.getCart())
         case .payment:
             return PaymentController(oid:"1234",
                                      billingAddress: TestDataFactory.getAddress(key: "billing"),
                                      deliveryAddress: TestDataFactory.getAddress(key: "delivery"))
         case .address:
            return AddressViewController(order: TestDataFactory.getOrder(), addresses:TestDataFactory.getAddresses())
         }

    }
}
