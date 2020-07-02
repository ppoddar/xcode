//
//  TableCell.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 7/1/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

protocol TableCell {
    associatedtype Element
    var item:Element? {get set}
}
