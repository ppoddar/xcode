//
//  FileReader.swift
//  shakti
//
//  Created by Pinaki Poddar on 7/4/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation

enum Language : String, CaseIterable {
    case english, bangla
}

class FileReader {
    static func read(fileName:String) -> String? {
        // bundle is not packing files in a hierarchy.
        // Hence we encoe the file name for categorization
        // poem-(idx)-(language).(extension)
        NSLog("reading \(fileName)")
        do {
            let path = (Bundle.main.resourcePath!+fileName)
            //print(path)
            let content = try String(
                contentsOfFile: path,
                encoding: String.Encoding.utf8)
            //print("content \(content)")
            return content
        } catch {
            NSLog("***ERROR: reading \(fileName)")
            print(error)
        }
        NSLog("***ERROR:unexpected error reading \(fileName). Retuning emprty conent")
        return ""
    }
    
    static func readPoem(path:String, language:Language, ext:String = "html") -> String? {
        let fileName =  "/\(path)-\(language.rawValue).\(ext)"
        // bundle is not packing files in a hierarchy.
        // Hence we encoe the file name for categorization
        // poem-(idx)-(language).(extension)
        print("reading \(fileName)")
        do {
            let path = (Bundle.main.resourcePath!+fileName)
            //print(path)
            return try String(
                contentsOfFile: path,
                encoding: String.Encoding.utf8)
            //print("content \(content)")
        } catch {
            print("error reading \(fileName)")
            print(error)
        }
        return nil
    }

    
    
}
