//
//  IndexedDictionary.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
struct IndexedDictionary<V:Codable> : Codable  {
    private var delegate = Dictionary<String,V> ()
    var keyOrder:Array<String> = Array<String>()
    subscript (index:Int) -> V? {
        get {
            let key:String = keyOrder[index]
            return delegate[key]
        }
    }
    
    
    subscript (key:String) -> V? {
        get {
            return delegate[key]
        }
    }
    
      enum CodingKeys : CodingKey {
       }
    
    mutating func setValue(key:String, value:V) {
        keyOrder.append(key)
        delegate[key] = value
    }
    
    var count:Int {
        get {
            return delegate.count
        }
    }
    
    func unwrap() -> Dictionary<String,V> {
        return delegate
    }
    
    var keys:[String] {
        get {
            return keyOrder
        }
    }
    
    
    
    
}
