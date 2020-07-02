//
//  Address.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/16/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class Address: Codable,HasKeyProtcol {
    var kind: Kind
    var owner: String
    var line1: String
    var line2: String?
    var city: String?
    var zip: String
    var tips: String?
    
    enum Kind : String,Codable,CaseIterable {
        case home, apartment, office, billing
    }
    
    init() {
        kind = Kind.home
        owner = ""
        line1 = ""
        line2 = ""
        city = ""
        zip = ""
        tips = ""
    }
    
    init(kind:String,
         owner:String,
         line1:String,
         zip:String,
         line2:String? = "",
         city:String? = "",
         tips:String? = "") {
        
        self.kind = Kind(rawValue: kind) ?? Kind.home
        self.owner = owner
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.zip  = zip
        self.tips = tips
    }
    
    var key : String {
        get {return kind.rawValue}
    }
}
