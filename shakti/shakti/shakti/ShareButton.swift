//
//  ShareButton.swift
//  shakti
//
//  Created by Pinaki Poddar on 7/5/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class ShareButton: UIButton {
    var controller:PoemViewController?
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        clipsToBounds = true
        
        setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        addTarget(self, action: #selector(share), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func share() {
        
    }
    
    

}
