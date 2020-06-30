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
    var placeHolder:UILabel
    var placeHolderShown:Bool
    init(placeHolderText:String="", lines:Int=8) {
        self.placeHolder = UILabel()
        self.placeHolder.text = placeHolderText
        self.placeHolderShown = false
        let frame:CGRect = CGRect(x:0, y:0,
            width:Int(UIScreen.main.bounds.width),
            height:Int(lines*Int(UIConstants.LABEL_HEIGHT)))
        super.init(frame: frame, textContainer:nil)
        
        configurePlaceHolder()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.inputAccessoryView = doneToolbar()
    }
    
    func configurePlaceHolder() {
        self.addSubview(placeHolder)
        placeHolder.frame = CGRect(x:0, y:0, width:100, height:24)
        placeHolder.sizeToFit()
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
           print("textViewDidEndEditing")
        //self.resignFirstResponder()

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
            //self.isEditable = false
            //self.textViewDidEndEditing(self)
            self.endEditing(true)
        }
    
}
