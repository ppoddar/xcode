//
//  MutableTabular.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 7/1/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
protocol MutableTabluar:BaseTabular {
    associatedtype E
    
    func addElement(e:E) -> Void
}
