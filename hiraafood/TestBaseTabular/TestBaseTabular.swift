//
//  TestBaseTabular.swift
//  TestBaseTabular
//
//  Created by Pinaki Poddar on 7/1/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import XCTest
@testable import hiraafood
class TestBaseTabular: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOrderIsIterable() {
        
    }

    func testOrderTotal() throws {
        //let order:Order = TestDataFactory.getOrder()
        
        //order.items()
        
        let i1:Item = Item(sku: "101", name: "", category: "", price: 5.99, desc: "", rating: 4, image: "")
        let i2:Item = Item(sku: "102", name: "", category: "", price: 6.99, desc: "", rating: 4, image: "")

        let o1:OrderItem = OrderItem(item: i1, units: 4)
        let o2:OrderItem = OrderItem(item: i2, units: 3)
        
        let cart:Cart = Cart()
        let order:Order = Order(id: "1234")
        order.addElement(o1)
        order.addElement(o2)
        cart.addElement(o1)
        cart.addElement(o2)

        
        let expected = i1.price*4 + i2.price*3
        var actual = order.total
        assert(actual == expected,
            "order actual \(actual) not equal to expected \(expected)")
        actual = cart.total
        assert(actual == expected,
            "cart actual \(actual) not equal to expected \(expected)")
    }

}
