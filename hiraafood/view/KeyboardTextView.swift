//
//  KeyboardTextView.swift
//  hiraafood5
//
//  Created by Pinaki Poddar on 6/22/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit
/*
 * Handles virtual keyboad with a placehoder
 */
class KeyboardTextView: UITextView, UITextViewDelegate {
    var placeHolder:UITextView
    var placeHolderShown:Bool
    var lineCount:Int
    init(placeHolderText:String="", lineCount:Int=4) {
        self.placeHolder = UITextView()
        self.placeHolder.text = placeHolderText
        self.placeHolderShown = false
        self.lineCount = lineCount
        super.init(frame: .zero, textContainer:nil)
        
        textContainer.lineBreakMode = .byWordWrapping
        self.backgroundColor = UIConstants.COLOR_MUTED

        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.inputAccessoryView = doneToolbar()
        
        configurePlaceHolder()

    }
    
    func configurePlaceHolder() {
        //placeHolder.frame = CGRect(x:10, y:10, width:200, height:24)
        //placeHolder.sizeToFit()
        placeHolder.backgroundColor = self.backgroundColor
        placeHolder.tintColor = UIConstants.COLOR_MUTED

        self.addSubview(placeHolder)
        //placeHolder.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //placeHolder.leftXAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (!placeHolderShown) {
            placeHolderShown = true
            placeHolder.removeFromSuperview()
        }
        self.backgroundColor = .white
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
           NSLog("textViewDidEndEditing")
    }
      
    func doneToolbar() -> UIToolbar {
            let doneToolbar: UIToolbar = UIToolbar(frame:
                CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIConstants.LABEL_HEIGHT))
            doneToolbar.barStyle = .default
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(self.doneButtonAction))
            
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }
        
        @objc func doneButtonAction() {
            self.endEditing(true)
        }
    
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: UIConstants.LINE_HEIGHT * CGFloat(lineCount))
        }
    }
    
}
