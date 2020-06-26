//
//  BaseControllerViewController.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/24/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func raiseAlert(_ title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func goto(page:UIViewController) {
        DispatchQueue.main.async {
            //let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(page, animated: true)
        }
    }
    
    func convertServerResponse<T:Decodable>(_ result:Result<Data,ApplicationError>) throws -> T {
        let rawData = try result.get()
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: rawData)
    }
}
