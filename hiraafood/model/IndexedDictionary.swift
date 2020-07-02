//
//  IndexedDictionary.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
struct IndexedDictionary<V:Codable & HasKeyProtcol> : Codable  {
    
    var delegate = Dictionary<String,V> ()
    
    var keyOrder:Array<String> = Array<String>()
    
    enum CodingKeys : CodingKey {
    }
    
    func makeIterator() -> Dictionary<String,V>.Iterator {
        return delegate.makeIterator()
    }
    
    var count:Int {
        get {
            return delegate.count
        }
    }
    
    
    
    subscript (index:Int) -> V? {
        get {
            return delegate[keyOrder[index]]
        }
    }
    
    subscript (key:String) -> V? {
        get {
            return delegate[key]
        }
    }
    
    mutating func addElement(_ e:V) {
        let key:String = e.key
        keyOrder.append(key)
        delegate[key] = e
    }
    
    var orderedValues:[V] { get {
        return Array(delegate.values)
    }}
    
    var keys:[String] { get {
        return keyOrder
        }}
    func unwrap() -> Dictionary<String,V> {
        return delegate
    }
    
    
    
    
    
}
