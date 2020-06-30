//
//  Counter.swift
//  hiraafood5
//
//  Created by Pinaki Poddar on 6/23/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit
class Counter: UIStackView {
    var stepper:UIStepper = UIStepper()
    var label:UIButton = UIButton()
    
    init() {
        self.start = 1
        super.init(frame:.zero)
        updateValue(v: 1)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        
        stepper.minimumValue = Double(1)
        stepper.isContinuous = false
        stepper.wraps = false
        stepper.stepValue = 1
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var value:Int {
        get {
            return Int(stepper.value)
        }
    }
    
    var start:Int {
        didSet {
            stepper.value = Double(start)
            setupView()
        }
    }
    
    func setupView() {
        let plus  = UIImageView(image:UIImage(systemName: "plus.square.fill",  withConfiguration: UIImage.SymbolConfiguration(scale: .medium)))
        let minus = UIImageView(image:UIImage(systemName: "minus.square.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)))
        plus.tintColor = .blue
        minus.tintColor = .blue
        stepper.setIncrementImage(plus.image, for: .normal)
        stepper.setDecrementImage(minus.image, for: .normal)
        stepper.addTarget(self, action: #selector(changeQuantity), for:.valueChanged)
        
        
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        label.setTitle(String(Int(stepper.value)), for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.isUserInteractionEnabled = false
        UIFactory.border(label)
        addArrangedSubview(UIFactory.label("how many? "))
        addArrangedSubview(label)
        addArrangedSubview(stepper)
    }
    
    func updateValue(v:Double) {
        label.setTitle(String(Int(v)), for: .normal)
    }
    
    
    @objc func changeQuantity(_ sender:UIStepper) {
        updateValue(v: sender.value)
    }
    
}
