//
//  KeyboardTextView.swift
//  hiraafood5
//
//  Created by Pinaki Poddar on 6/22/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class KeyboardTextView: UITextView, UITextViewDelegate {
    var placeholder:String
    init(placeHolder:String, lines:Int?=8) {
        self.placeholder = placeHolder
        let frame:CGRect = CGRect(x:0, y:0,
            width:Int(UIScreen.main.bounds.width),
            height:Int(lines!*Int(UIConstants.LABEL_HEIGHT)))
        super.init(frame: frame, textContainer:nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self

        addDoneButtonOnKeyboard()
        self.text = placeHolder
        self.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //print("textViewDidBeginEditing")
        textView.text = nil
    }
    
    
    
    func addDoneButtonOnKeyboard() {
            let doneToolbar: UIToolbar = UIToolbar(frame:
                CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIConstants.LABEL_HEIGHT))
            doneToolbar.barStyle = .default
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done,
                                            target: self, action: #selector(self.doneButtonAction))
            
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            
            self.inputAccessoryView = doneToolbar
        }
        
        @objc func doneButtonAction() {
            self.isEditable = false
            self.resignFirstResponder()
        }
    
}
