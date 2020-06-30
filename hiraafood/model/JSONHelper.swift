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
            print("jsonFromObject \(obj)")
            return try JSONEncoder().encode(obj)
            
            //return try JSONSerialization.data(withJSONObject: obj, options: [])
        } catch  {
            print("***ERROR: jsonFromObject \(obj)")

            print(error)
            return nil
        }
    }
    
    func jsonFromDict<V:Codable>(type:Codable.Type, dict:IndexedDictionary<V>) -> Data? {
        let N = dict.count
         print("converting dictionary of size \(N) to JSON String")
         var values:[String] = [String](repeating: "", count: N)
        var i:Int = 0
         for key in dict.keys {
             let value:V = dict[key]!
             print("key= \(key)")
             print("value= \(value)")
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
             print("final JSON")
             print(json)
            return json.data(using: .utf8)
         }
        
    }
    

