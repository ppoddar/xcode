//
//  Storage.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/16/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation

class Storage {
    static func saveCart(_ cart:Encodable) {
        do {
            let jsonData = cart.toJSONData()
            let jsonString = String(data:jsonData!, encoding: .utf8)
                        
            let filename = self.getFileByKey(key: "cart")
            try jsonString?.write(to: filename,
                                  atomically: true,
                                  encoding: String.Encoding.utf8)
        } catch {
            print("failed to save cart")
            print(error)
        }
    }
    
    static func loadCart() -> Cart {
        do {
            let fileURL = self.getFileByKey(key: "cart")
            print("loading cart... from \(fileURL)")
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            let json:Data? = text.data(using: .utf8)
            return
                try JSONDecoder().decode(Cart.self, from:json!)
        } catch {
            print("error while loading cart from file. Would be returning an empty cart")
            print(error)
            return Cart()
        }
    }
    
    static func getFileByKey(key:String) -> URL{
        let fileURL:URL = getDocumentsDirectory()
            .appendingPathComponent(key + ".json")
        self.ensureFileExits(filepath: fileURL)
        return fileURL
    }
    
    static func ensureFileExits(filepath:URL) {
        let filemgr = FileManager.default
        let filepath = (filepath.path)
        if (!filemgr.fileExists(atPath: filepath)) {
            print("Creating file with empty JSON data \(filepath)")
            let empty = "{}".data(using: String.Encoding.utf8)
            filemgr.createFile(atPath: filepath, contents: empty, attributes: nil)
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                in: .userDomainMask)
        return paths[0]
    }
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}



