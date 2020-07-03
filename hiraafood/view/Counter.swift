//
//  Counter.swift
//  hiraafood5
//
//  Created by Pinaki Poddar on 6/23/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit
class Counter: UIStackView {
    var stepper:UIStepper
    var valueField:UIButton
    var label:UILabel

    init(text:String,start:Int=1) {
        self.stepper = UIStepper()
        self.valueField = UIButton()
        self.label = UIFactory.label(text)
        
        super.init(frame:.zero)
        
        axis = .horizontal
        alignment    = .top
        distribution = .equalSpacing

        self.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        valueField.translatesAutoresizingMaskIntoConstraints = false
        stepper.value = Double(start)
        updateValue()
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white

        stepper.minimumValue = Double(1)
        stepper.isContinuous = false
        stepper.wraps = false
        stepper.stepValue = 1
        
        addArrangedSubview(label)
        addArrangedSubview(valueField)
        addArrangedSubview(stepper)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var value:Int {
        get {
            return Int(stepper.value)
        }
    }
    
    func setupView() {
        let plus  = UIImageView(image:UIImage(systemName: "plus.square.fill",  withConfiguration: UIImage.SymbolConfiguration(scale: .medium)))
        let minus = UIImageView(image:UIImage(systemName: "minus.square.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)))
        stepper.setIncrementImage(plus.image, for: .normal)
        stepper.setDecrementImage(minus.image, for: .normal)
        stepper.addTarget(self, action: #selector(updateValue), for:.valueChanged)
        
        valueField.isUserInteractionEnabled = false
        valueField.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        valueField.setTitle(String(Int(stepper.value)), for: .normal)
        valueField.setTitleColor(.black, for: .normal)
        
        UIFactory.border(label)
        UIFactory.border(valueField)
        UIFactory.border(stepper)
        UIFactory.border(self)
        
        label.setContentHuggingPriority                   (UILayoutPriority.defaultLow,  for: .horizontal)
        label.setContentCompressionResistancePriority     (UILayoutPriority.defaultHigh,  for: .horizontal)
        valueField.setContentHuggingPriority              (UILayoutPriority.defaultHigh, for: .horizontal)
        valueField.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
    
    @objc func updateValue() {
        let v:Double = stepper.value
        valueField.setTitle(String(Int(v)), for: .normal)
    }
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 200, height: UIConstants.BUTTON_HEIGHT)
        }
    }
    
}
