//
//  JSONHelper.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/28/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
class JSONHelper {
    /*
     
     */
    func jsonFromObject<V:Codable>(type:Codable.Type,  obj:V) ->  Data? {
        do {
            NSLog("jsonFromObject \(obj)")
            return try JSONEncoder().encode(obj)
            
            //return try JSONSerialization.data(withJSONObject: obj, options: [])
        } catch  {
            NSLog("***ERROR: jsonFromObject \(obj)")

            NSLog(String(describing: error))
            return nil
        }
    }
    
    func jsonFromDict<V:Codable>(type:Codable.Type, dict:IndexedDictionary<V>) -> Data? {
        let N = dict.count
         NSLog("converting dictionary of size \(N) to JSON String")
         var values:[String] = [String](repeating: "", count: N)
        var i:Int = 0
         for key in dict.keys {
             let value:V = dict[key]!
             NSLog("key= \(key)")
             NSLog("value= \(value)")
            let data:Data = jsonFromObject(type: V.self, obj: value)!
             values[i] = String(data:data, encoding: .utf8)!
             i += 1
         }
         var json:String = Server.OPEN
             for i in 0..<N {
                json += Server.QUOTE + dict.keys[i] + Server.QUOTE + Server.COLON + values[i]
                 if (i < (N-1)) {json += ","}
             }
             json += Server.CLOSE
             NSLog("final JSON")
             NSLog(json)
            return json.data(using: .utf8)
         }
        
    }
    

